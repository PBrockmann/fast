#!/bin/bash -x

#===============================================================
# create_anomalies.bash file var qualifiers dirdest yearref yearstart yearend

#===============================================================
#create_anomalies.bash /dmnfs09/cont003/p86caub/IGCM_OUT/IPSLCM5A/PROD/piControl/piControl2/ATM/Analyse/TS_MO_YE/piControl2_18000101_27991231_1Y_t2m.nc t2m "/pal=blue_darkred/lev=(-INF)(-6,6,0.25)(INF)" piControl2 1980 1980 1990
create_anomalies.bash http://dods.extra.cea.fr/cgi-bin/nph-dods/data/p86caub/IPSLCM5A/PROD/piControl/piControl2/ATM/Analyse/TS_MO_YE/piControl2_18000101_27991231_1Y_t2m.nc t2m "/pal=blue_darkred/lev=(-INF)(-6,6,0.25)(INF)" piControl2 1980 1980 1990

#===============================================================
#create_anomalies.bash /dmnfs09/cont003/p86denv/IGCM_OUT/IPSLCM5A/PROD/historical/v3.historical1/ATM/Analyse/TS_MO_YE/v3.historical1_18500101_20051231_1Y_t2m.nc t2m "/pal=blue_darkred/lev=(-INF)(-6,6,0.25)(INF)" v3.historical1 1980 1980 1990
create_anomalies.bash http://dods.extra.cea.fr/cgi-bin/nph-dods/data/p86denv/IPSLCM5A/PROD/historical/v3.historical1/ATM/Analyse/TS_MO_YE/v3.historical1_18500101_20051231_1Y_t2m.nc t2m "/pal=blue_darkred/lev=(-INF)(-6,6,0.25)(INF)" v3.historical1 1980 1980 1990
