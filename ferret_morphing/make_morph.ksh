#!/bin/ksh

rm -f frame_*gif

convert -resize 40%x40% -morph 5 tt1.gif tt2.gif tt3.gif tt4.gif frame_%02d.gif 

convert -loop 0 -delay 50 `ls frame_??.gif` `ls -r frame_?[1-9].gif` present_02.gif

rm -f frame_*gif
