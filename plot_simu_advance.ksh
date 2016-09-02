#!/bin/ksh 

#**************************************************************
# Description: Create an image to show current state of a run
#
#  Usage: plot_simu_advance.ksh simu_start simu_end simu_delta simu_title simu_present imagename 
#
#  Example: plot_simu_advance.ksh 1800 2500 50 "Current year: 2005<NL> <NL>Simulation IPCC<NL>Scenario CO2x2<NL>Run 1800-2500" 2005 /dir1/dir2/imagename.gif 
#
# Author: Patrick Brockmann
# Contact: Patrick.Brockmann@ipsl.jussieu.fr
# History:
# Modification:
#
#**************************************************************

simu_start=$1
simu_end=$2
simu_delta=$3
simu_title=$4
simu_present=$5
imagename=$6

exec 2>&1 1>/dev/null
ferret -server -gif -script plot_simu_advance.jnl $simu_start $simu_end $simu_delta \"$simu_title\" $simu_present $imagename


