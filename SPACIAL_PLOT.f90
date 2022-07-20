
! ---- Program Main READ DART OBSSEQ FINAL FILES FOR 30 ENSEMBLE MEMBER------
! ----Author: Dr. Swapan Mallick -------------------------
! ----Date: 23 MAY 2022, CMCC ---------
!
!
        IMPLICIT NONE
        INTEGER n1, nv, mv, i,j,k,l,m,n,TYPE_DATA,ens,ll
        PARAMETER (nv=143143274)
        PARAMETER (mv=43143274)
        !PARAMETER (nv=22100658)
        CHARACTER*100 file_inp
        CHARACTER*85 filelist(nv)
        CHARACTER*85 file11, file22, file33, file44, file55
        CHARACTER*85 file66, file77
        CHARACTER*85 file_GPT, file_GPO, file_MWT, file_MWO
        CHARACTER*30 OBS_PR1, OBS_PO1, PRI_ES1, POS_ES1
        CHARACTER*30 ENSM1, ENSM2
        INTEGER, PARAMETER :: TT1 = 19 !change here for OBSTYPE
        INTEGER, PARAMETER :: TT = 20 !change here for OBSTYPE
        INTEGER, PARAMETER :: CH = 7  !  AMSU total Channel
        INTEGER, PARAMETER :: ens_size = 30
!
! ------ This progream is for 30 ensemble member-------
! -----For different ensemble member like 80 change ens_size=80
!
        INTEGER, PARAMETER, DIMENSION(19) :: TYPE1 = (/ 5,6,9,16,17,18,34, &
         & 35,4,37,20,21,22,24,25,26,44,46,47/)
        INTEGER, PARAMETER, DIMENSION(7) :: CH1 = (/15000,9000,    &
        &  5000,2500,1000,500,250/)
        !INTEGER, PARAMETER, DIMENSION(21) :: TYPE1 = (/ 4,5,6,9,10, &
        ! &   16,17,18,20,21,22,24,25,26,27,34,35,44,46,47,214 /)
        REAL QC1, QC2
        REAL LONG, LATD, HGT
        REAL QC11, QC22, OBS_VAL
        INTEGER TYPE33(TT,mv)
        CHARACTER*10 CHA1(mv)
        REAL LONG3(TT,mv),LATD3(TT,mv)
        REAL HGT33(TT,mv),OBS_VAL33(TT,mv)
        REAL ENMEM1,ENMEM2
        REAL OBS_PR, OBS_PO, PRI_ES, POS_ES
        REAL RMSF,RMSA,SDF,SDA,ff,OBS_VAR
"~/Desktop/EXP-1/SPACIAL_PLOT.f90" 158L, 6030B
