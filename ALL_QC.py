import matplotlib.pyplot as plt
from matplotlib import rcParams
from matplotlib.ticker import FixedLocator
from mpl_toolkits.basemap import Basemap
import numpy as np
##
KIND, LON, LAT, HGT, OBS, QC1, QC2 =  np.loadtxt('fort.FORTNO',skiprows=2, usecols=range(0,7), unpack=True)
QC=QC2
nobs=len(OBS)
print(OBS)
CLATH1=LAT
CLONH1=LON
print(np.max(CLONH1),np.min(CLONH1))
print(np.max(CLATH1),np.min(CLATH1))
LAT11=np.empty(nobs);LON11=np.empty(nobs)
LAT22=np.empty(nobs);LON22=np.empty(nobs)
QC11=np.empty(nobs);QC22=np.empty(nobs)
k=0;l=0
for i in range(0,nobs):
    if(QC2[i]>=1.0):
       LAT11[k]=CLATH1[i];LON11[k]=CLONH1[i];QC11[k]=1
       k=k+1 
    if(QC2[i]<1.0):
       LAT22[l]=CLATH1[i];LON22[l]=CLONH1[i];QC22[l]=10
       l=l+1
#
obs_usd=l
obs_reg=k
print("ASSIM ==",l)
print("REJ ==",k)
tot = obs_usd+obs_reg
prec = obs_usd/tot *100
#
def FIG1(channel):
    plt.rcParams['font.size'] = 18
    plt.rcParams['font.family'] = 'serif'
    plt.rcParams['axes.linewidth'] = 1.5 
    fig = plt.figure(figsize=(12, 10))
    ax1 = fig.add_subplot(111)
    ax1.xaxis.set_major_locator(FixedLocator(np.arange(-180, 181, 60)))
    ax1.yaxis.set_major_locator(FixedLocator(np.arange(-90, 91, 30)))
    ax1.set_xticklabels(['-180', '-120', '-60', '0', '60', '-120', '180'])
    ##ax1.set_xticklabels(['0', '60', '120', '180', '240', '300', '360'])
    ax1.set_yticklabels(['90S', '60S', '30S', 'EQ', '30N', '60N', '90N'])

    m = Basemap( projection       = 'cyl',
                 llcrnrlon        = -180 , #Lower Left  CoRNeR Longitude
                 urcrnrlon        = 180  , #Upper Right CoRNeR Longitude
                 llcrnrlat        = -90  , #Lower Left  CoRNeR Latitude
                 urcrnrlat        = 90   , #Upper Right CoRNeR Latitude
                 resolution       = 'c'  ,
                 suppress_ticks   = False)
    m.drawcoastlines(linewidth=0.9, color='black')
    if (channel==1):
        x1, y1 = m(LON11, LAT11)
        x2, y2 = m(LON22, LAT22)
        cs1 = m.scatter(x1, y1, s=6.0, c=QC11,edgecolor='red', cmap='Reds')
        cs1 = m.scatter(x2, y2, s=3.0, c=QC22,edgecolor='blue', cmap='Blues')
        ##cs1 = m.scatter(x, y, s=5.0, c=SCRA,vmin=0,vmax=np.max(SCRA),edgecolor='none', cmap='jet')
        plt.rcParams.update({'font.size': 15})
        count1=nobs
        plt.text(0, 130, 'CMCC-DART MONITORING STATISTICS',horizontalalignment='center',fontsize=20,verticalalignment='center',rotation='horizontal',color="Green")
        plt.rcParams['font.size'] = 14
        plt.text(0, 115, 'FILENAME (OBS) date_sm at HH_sm UTC (+/- 3HR)',fontstyle='italic',fontsize=16,horizontalalignment='center',verticalalignment='center',rotation='horizontal', color="Blue")
        plt.text(-160, 105, 'ASSIM OBS = ',horizontalalignment='left',verticalalignment='top',rotation='horizontal',color="Blue")
        plt.text(-110, 105, '%10.0f' % obs_usd, horizontalalignment='left',verticalalignment='top',rotation='horizontal', color="Blue")
        plt.text(60, 105, 'REJECTED OBS = ',horizontalalignment='left',verticalalignment='top',rotation='horizontal',color="Red")
        plt.text(130, 105, '%10.0f' %obs_reg , horizontalalignment='left',verticalalignment='top',rotation='horizontal', color="Red")
        plt.rcParams['font.size'] = 15
#
        plt.savefig('FILENAME_QC.png')
    ###
if __name__ == '__main__':
    FIG1(1)
quit()
