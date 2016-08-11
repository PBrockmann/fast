#!/usr/bin/env python

import sys
import webcolors

print "RGB_Mapping By_level"

n=0
with open(sys.argv[1]) as fp:
    for line in fp:
	R,G,B = webcolors.hex_to_rgb_percent(line)
	R = R.split('%')[0]
	G = G.split('%')[0]
	B = B.split('%')[0]
	n = n+1
	print n, R, G, B
