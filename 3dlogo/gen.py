import json
import sys
from pathlib import Path

# https://andrewsink.github.io/STL-to-ASCII-Generator/
#
# paste this into js console, wait a bit, do `copy(a)` and pipe into the program
#
# a = []
# setInterval(function () {
#   a.push(document.getElementsByTagName("td")[0].innerHTML)
# }, 500)

frames = []

for line in sys.stdin.readlines():
    if len(line.split('"')) < 3:
        continue
    frame = line.split('"')[1].replace("&nbsp;", " ").split("<br>")
    if len(frame) > 67:
        frame = frame[(len(frame) - 67) // 2 : len(frame) - (len(frame) - 67) // 2]
    frames.append("\n".join(frame))
    if len(frame[0]) > 238:
        for frameline in frame:
            frameline = frameline[
                (len(frameline) - 238) // 2 : len(frameline)
                - (len(frameline) - 238) // 2
            ]

for i, frame in enumerate(frames):
    Path(f"frame{str(i).zfill(2)}").write_text(frame)
