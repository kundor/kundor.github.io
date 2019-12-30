#!/usr/bin/python3

# Antiprism Resource File - http://www.antiprism.com
# This file may be copied, modified and redistributed
#
# Example animation of a spinning polyhedron
# Adrian Rossiter <adrian@antiprism.com>

import subprocess
#import io
#from PIL import Image
# For some reason using Pillow instead of imagemagick convert makes a file bigger, slower, and without transparency
# :(

from math import sqrt,cos,radians,pi
from itertools import chain


width = 300
height = 280
N = 5
totang = 360 #// N

povfile = "/tmp/anim_tmp.pov" # on a tmpfs
# command line to render a file
povray_cmd = f"povray +A +H{height} +W{width} -D -GA +UA declare=AspectRatio={width/height} -I{povfile}"
# +A: anti-alias
# -D: no display window
# -GA: suppress console output (initial banner/credits cannot be suppressed)
# +UA: transparent background
povray_cmd = povray_cmd.split()

pngs = []
i = 0
#for ang in chain(range(totang), range(totang-2, 0, -1)):
#    hgt = sqrt(2*(cos(radians(ang)) - cos(2*pi/N)))
for ang in range(0, totang, 3):
    pngfile = f"panim_{i:03}.png"
    i += 1
    # piping the .pov to povray -I- should work. But it doesn't
    # https://github.com/POV-Ray/povray/issues/35
#    subprocess.run(f"polygon -r 1 -l {hgt} -a {ang} prism {N} | "
#          f"off_color -f N -m map_3=yellow:{N}=blue | "
#           "off_trans -R 110,0,0 | "
    subprocess.run(f"off_trans -R {ang},0,0 isotrapfrust.off | "
          f"off2pov -v 0.0 -E 0.5,0.5,0.7 -e 0.013 -B black -D 100 -C 0,-0.1,0 -o {povfile}",
          shell=True)
    pngpipe = subprocess.run(povray_cmd + [f"-O{pngfile}"], stderr=subprocess.DEVNULL, stdout=subprocess.PIPE)
    pngs.append(pngfile)
    #images.append(Image.open(io.BytesIO(pngpipe.stdout)))

#images[0].save('panim.gif', save_all=True, append_images=images[1:], duration=60, loop=0, disposal=2)

subprocess.run(["convert", "-delay", "6",
                "-loop", "0",
                "-dispose", "2"]
                + pngs + ["panim.gif"])


