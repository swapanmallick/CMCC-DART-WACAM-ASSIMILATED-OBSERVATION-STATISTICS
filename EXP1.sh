#!/bin/sh
#################################################################
#  CMCC DART OBS-SEQ-IN FILE PLOTS
#  Author Dr. Swapan Mallick
#  Date 13 MAY 2022 at CMCC
#################################################################
#
EXP=exp14init
USERNAME=sm09722
YYYY=2017
MM=11
##for DD in 02 ;do
for DD in {02..03}; do
##for DD in 01;do
DATE1=${YYYY}${MM}${DD}
#
FINAL_OUT=/work/csp/sm09722/OBS_MONITOR_FINAL
mkdir -p ${FINAL_OUT}
SCRIPT=/users_home/csp/sm09722/OBS_DARTINPUT/PROGOBS_OUTUTC_JUNE2022/EXP-1
WRKDIR=/work/csp/sm09722/observations/PLOTS_FINAL/${EXP}_OBSPLOTS/${DATE1}_OUT
rm -rf ${WRKDIR}
mkdir -p ${WRKDIR}
echo ${WRKDIR}
for HRR in 00000 ; do
#for HRR in 00000 21600 43200 64800; do
##for HRR in 00000 21600 43200 64800 ; do
   if [ ${HRR} = 00000 ];then
      UTC1="00"
      echo ${UTC1}
   elif [ ${HRR} = 21600 ];then
      UTC1="06"
      echo ${UTC1}
   elif [ ${HRR} = 43200 ];then
      UTC1="12"
      echo ${UTC1}
   elif [ ${HRR} = 64800 ];then
      UTC1="18"
      echo ${UTC1}
   fi
DATAFILE=/work/csp/${USERNAME}/CESM2/archive/${EXP}/${EXP}-${YYYY}-${MM}-${DD}-${HRR}/${EXP}.dart.e.cam_obs_seq_final.${YYYY}-${MM}-${DD}-${HRR}
#
echo ${DATAFILE}
cd ${WRKDIR}
cp -f ${SCRIPT}/SPACIAL_PLOT.exe ./
cp -f ${SCRIPT}/ALL_QC.py ./
cp -f ${DATAFILE} file_inp 
#
./SPACIAL_PLOT.exe
rm -rf SPACIAL_PLOT.exe file_inp
#
#-------------PLOTING----------
#
rm -rf fort.105 fort.106 fort.104
file1=10
for TYPE_PLOT in RADIOSONDE_U_WIND AIRCRAFT_U_WIND SATWIND_U_WIND MARINE_SFC_ALTIMETER AIRS_BT AMSU-CH8 ; do
##for TYPE_PLOT in RADIOSONDE_U_WIND RADIOSONDE_V_WIND RADIOSONDE_TEMP AIRCRAFT_U_WIND AIRCRAFT_V_WIND AIRCRAFT_TEMP SATWIND_U_WIND SATWIND_V_WIND GPSRO_REFRACTIVITY MARINE_SFC_U_WIND MARINE_SFC_V_WIND MARINE_SFC_TEMP RADIOSONDE_SURFACE_ALTIMETER MARINE_SFC_ALTIMETER LAND_SFC_ALTIMETER  AIRS_BT AMSU-CH8 AMSU-CH9 AMSU-CH10 AMSU-CH11 AMSU-CH12 AMSU-CH13 AMSU-CH14 ; do
#
file1=`expr $file1 + 1`
#
if [ ${TYPE_PLOT} = RADIOSONDE_U_WIND ];then
      UTCORTNO="201"
elif [ ${TYPE_PLOT} = RADIOSONDE_V_WIND ];then
      UTCORTNO="202"
elif [ ${TYPE_PLOT} = RADIOSONDE_TEMP ];then
      UTCORTNO="203"
elif [ ${TYPE_PLOT} = AIRCRAFT_U_WIND ];then
      cat fort.204 fort.211 >> fort.104
      UTCORTNO="104"
elif [ ${TYPE_PLOT} = AIRCRAFT_V_WIND ];then
      cat fort.205 fort.212 >> fort.105
      UTCORTNO="105"
elif [ ${TYPE_PLOT} = AIRCRAFT_TEMP ];then
      cat fort.206 fort.213 >> fort.106
      UTCORTNO="106"
elif [ ${TYPE_PLOT} = SATWIND_U_WIND ];then
      UTCORTNO="207"
elif [ ${TYPE_PLOT} = SATWIND_V_WIND ];then
      UTCORTNO="208"
elif [ ${TYPE_PLOT} = GPSRO_REFRACTIVITY ];then
      UTCORTNO="209"
elif [ ${TYPE_PLOT} = AIRS_BT ];then
      UTCORTNO="210"
elif [ ${TYPE_PLOT} = ACARS_U_WIND ];then
      UTCORTNO="211"
elif [ ${TYPE_PLOT} = ACARS_V_WIND ];then
      UTCORTNO="212"
elif [ ${TYPE_PLOT} = ACAR_TEMP ];then
      UTCORTNO="213"
elif [ ${TYPE_PLOT} = MARINE_SFC_U_WIND ];then
      UTCORTNO="214"
elif [ ${TYPE_PLOT} = MARINE_SFC_V_WIND ];then
      UTCORTNO="215"
elif [ ${TYPE_PLOT} = MARINE_SFC_TEMP ];then
      UTCORTNO="216"
elif [ ${TYPE_PLOT} = RADIOSONDE_SURFACE_ALTIMETER ];then
      UTCORTNO="217"
elif [ ${TYPE_PLOT} = MARINE_SFC_ALTIMETER ];then
      UTCORTNO="218"
elif [ ${TYPE_PLOT} = LAND_SFC_ALTIMETER ];then
      UTCORTNO="219"
elif [ ${TYPE_PLOT} = AMSU-CH8 ];then
      UTCORTNO="421"
elif [ ${TYPE_PLOT} = AMSU-CH9 ];then
      UTCORTNO="422"
elif [ ${TYPE_PLOT} = AMSU-CH10 ];then
      UTCORTNO="423"
elif [ ${TYPE_PLOT} = AMSU-CH11 ];then
      UTCORTNO="424"
elif [ ${TYPE_PLOT} = AMSU-CH12 ];then
      UTCORTNO="425"
elif [ ${TYPE_PLOT} = AMSU-CH13 ];then
      UTCORTNO="426"
elif [ ${TYPE_PLOT} = AMSU-CH14 ];then
      UTCORTNO="427"
#
fi
echo " Hi Swapan Now I am doing--"
echo ${TYPE_PLOT}
echo "---------------------------"
#----------------SPATIAL PLOTS-------------------
DATE_SM=${YYYY}${MM}${DD}${UTC1}
sed "s/date_sm/${DATE1}/g"  ALL_QC.py > aa.py
sed "s/HH_sm/${UTC1}/g" aa.py > bb.py
sed "s/FILENAME/${TYPE_PLOT}/g" bb.py > cc.py
sed "s/FORTNO/${UTCORTNO}/g" cc.py > dd.py
python dd.py
mv ${TYPE_PLOT}_QC.png ${file1}_${TYPE_PLOT}_${DATE1}${UTC1}_QC.png
rm -rf aa.py bb.py cc.py dd.py obs.txt dd.txt
#
done
rm -rf fort.*
done
rm -rf ${FINAL_OUT}/${EXP}_SPATIAL_OBS${DATE1}_${UTC1}.pdf
convert *.png ${FINAL_OUT}/${EXP}_SPATIAL_OBS${DATE1}_${UTC1}.pdf
echo ${FINAL_OUT}/${EXP}_SPATIAL_OBS${DATE1}_${UTC1}.pdf
#----LOOP DAYS------
done
rm -rf ALL_QC.py
cd ${SCRIPT}
exit
