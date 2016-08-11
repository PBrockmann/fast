#!/bin/bash

#===========================================================
dirmontage=`type -p $0`.misc

#===========================================================
dir1=$1
dir2=$2

#===========================================================
dir3=montage_${dir1##frames_}_${dir2##frames_}
rm -rf $dir3
mkdir $dir3
echo "###################################"
echo "$dir3 created"

#===========================================================
for file in `ls -1 $dir1/*` ; do

	file1=`basename $file`
	year=`echo ${file1%%.png} | cut -d_ -f2`
	frame=`echo ${file1%%.png} | cut -d_ -f3`

	# crop and set transparency
	convert -transparent white -crop 490x490+140+90 +repage $dir1/$file1 $dir3/tmp1.png
	convert -transparent white -crop 490x490+140+90 +repage $dir2/$file1 $dir3/tmp2.png

	# resize	
	convert -geometry 420x420 $dir3/tmp1.png $dir3/ok1.png
	convert -geometry 420x420 $dir3/tmp2.png $dir3/ok2.png

	# compose
	composite -gravity center -geometry -210-30 $dir3/ok1.png $dirmontage/fond_02.png $dir3/final1.png
	composite -gravity center -geometry +210-30 $dir3/ok2.png $dir3/final1.png $dir3/final2.png

	# annotate
	convert -font Helvetica-Bold -fill gray90 \
		-gravity Center -density 150 -draw 'text -210,-260 "'${dir1##frames_}'"' \
		-gravity Center -density 150 -draw 'text +210,-260 "'${dir2##frames_}'"' \
		-gravity NorthWest -density 300 -draw 'text +1020,+500 "'$year'"' \
		$dir3/final2.png $dir3/$file1
	
	echo "-----------------------------------"
	echo "$dir3/$file1 created"

done

#===========================================================
rm -rf $dir3/tmp*
rm -rf $dir3/ok*
rm -rf $dir3/final*

