#!/bin/bash

#===============================================================
file=$1
var=$2
qualifiers=$3
dirdest0=$4
yearref=$5
yearstart=$6
yearend=$7

#===============================================================
dirdest=frames_$dirdest0

rm -rf $dirdest
mkdir $dirdest
echo "###################################"
echo "$dirdest created"

#===============================================================
lonangle=0
latangle=40
for yearcur in `seq $yearstart $((yearend-1))` ; do 

	echo "-----------------------------------"
	echo "Processing $yearcur"
	ferret -gif -script create_anomalies.jnl \
		$file $var $qualifiers $yearref $yearcur $dirdest $lonangle $latangle \
		> /dev/null 2>&1

	# the script create_anomalies create 5 frames per lonangle 
	# 1st frame=100% of year1
	# 2nd frame=80% of year1 + 20% of year2
	# 3rd frame=60% of year1 + 40% of year2
	# 4th frame=40% of year1 + 60% of year2
	# 5rd frame=20% of year1 + 80% of year2
	let lonangle=lonangle+5

done

#===============================================================
