# CMCC-DART ASSIMILATED OBSERVATION MONITORING
This is a set of Shell, Fortran and Python codes for evaluating output from the CMCC Data Assimilation Research Testbed (DART).
FORTRAN-90 is used to extract the data from "**obs_seq.final**" files. The obs_seq_final T
To monitor the total number of observations used and assimilated in enseble-based CMCC-DART with the Whole Atmosphere Community Climate Model (WACCM). The codes are mostly written to accommodate all types of statistics including bias, RMSE, ensemble spread, observation influence, and many more.

# obs_seq.final
In each assimilation cycle, DART’s filter program assimilates the observations contained in the obs_seq.input file and generates an obs_seq.final file.
The "**obs_seq.final**" file contains all the information related to each observation including whether the observation is assimilated or not, the location (lat, long, height) observation error variance, observed value and simulated observed values for each ensemble member.
To learn more about the structure of the obs_seq.final file see the link https://docs.dart.ucar.edu/en/latest/guide/introduction-obs-seq-file.html?highlight=obs_seq


# Diagnosis of observation, background, and analysis error statistics in observation space
This folder contains a single FORTRAN program named "ALL_OBS_EXTRACT.F90" to extract information from  CMCC-DART "obs_sequnce" output files.
 
# How to Run the diagnostic file.
Two types of statistics are calculated using two different script
EXP-1. Statistics for a particular assimilation cycle
EXP-2. Time series for each type of observation were assimilated.

 EXP1.sh--->
 
    This file is used to extract the data from **obs_seq.final** for all observation types. 
    The observation includes RADIOSONDE_U_WIND RADIOSONDE_V_WIND RADIOSONDE_TEMP AIRCRAFT_U_WIND AIRCRAFT_V_WIND AIRCRAFT_TEMP SATWIND_U_WIND SATWIND_V_WIND GPSRO_REFRACTIVITY MARINE_SFC_U_WIND MARINE_SFC_V_WIND MARINE_SFC_TEMP RADIOSONDE_SURFACE_ALTIMETER MARINE_SFC_ALTIMETER LAND_SFC_ALTIMETER  AIRS_BT AMSU-CH8 AMSU-CH9 AMSU-CH10 AMSU-CH11 AMSU-CH12 AMSU-CH13 AMSU-CH14. 
    
    For all the listed observation types multiple **fort.***** will generate.
    A simple python program called **ALL_QC.py** will generate a spatial (Geographic) plot for each type of observation.
    And finally, all the images will be merged in a single PDF file called **${EXP}_SPATIAL_OBS${DATE1}_${UTC1}.pdf**
    
So EXP-1, needs to modify the input path and the run
> sh  EXP1.sh
