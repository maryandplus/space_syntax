#try kde for points
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(sf)
library(dplyr)
library(spatstat)
library(maptools)
#read and view road network shapefile
kob_network.sf <-st_read(dsn="XxXXXxxX/kob_network_final_verticesPOINTS.shp", layer="kob_network_final_verticesPOINTS")
st_crs(kob_network.sf) <- 25832 


#create point pattern from sf
ppp_network <- as.ppp(kob_network.sf$geometry)



#plot density
plot(density(ppp_network,sigma=300,eps=c(500,500),weights = kob_network.sf$AC_w400),main='AC_w400')
plot(density(ppp_network,sigma=300,eps=c(10,10), weights = kob_network.sf$AC_w400),main='AC_w400')
plot(density(ppp_network,sigma=300,eps=c(10,10), weights = kob_network.sf$AC_w800 ),main='AC_w800')
plot(density(ppp_network,sigma=300,eps=c(10,10), weights = kob_network.sf$AC_w1600 ),main='AC_w1600')
plot(density(ppp_network,sigma=300,eps=c(10,10), weights = kob_network.sf$AC_w2400 ),main='AC_w2400')
plot(density(ppp_network,sigma=300,eps=c(10,10), weights = kob_network.sf$AC_w10k ),main='AC_w10k')




library(raster)
#KDE angular choice
ch400 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AC_w400)
r_ch400 <- raster(ch400,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch400,'ch400.tif',options=c('TFW=YES'))


ch800 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AC_w800)
r_ch800 <- raster(ch800,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch800,'ch800.tif',options=c('TFW=YES'))

ch1600 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AC_w1600)
r_ch1600 <- raster(ch1600,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch1600,'ch1600.tif',options=c('TFW=YES'))

ch2400 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AC_w2400)
r_ch2400 <- raster(ch2400,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch2400,'ch2400.tif',options=c('TFW=YES'))

ch10k <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AC_w10k)
r_ch10k <- raster(ch10k,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch10k,'ch10k.tif',options=c('TFW=YES'))


#KDE angular integration
int400 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AI_w400)
r_int400 <- raster(int400,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_int400,'int400.tif',options=c('TFW=YES'))


int800 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AI_w800)
r_int800 <- raster(int800,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_int800,'int800.tif',options=c('TFW=YES'))

int1600 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AI_w1600)
r_int1600 <- raster(int1600,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_int1600,'int1600.tif',options=c('TFW=YES'))

int2400 <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AI_w2400)
r_int2400 <- raster(int2400,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_int2400,'int2400.tif',options=c('TFW=YES'))

int10k <-density(ppp_network,sigma=300,eps=c(50,50), weights = kob_network.sf$AI_w10k)
r_int10k <- raster(int10k,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_int10k,'int10k.tif',options=c('TFW=YES'))


#land use points
osm_points.sf <- st_read(dsn="xxxxxxxxxx/osm_kob_all.shp", layer="osm_kob_all")
st_crs(osm_points.sf) <- 25832 
ppp_landuse <- as.ppp(osm_points.sf$geometry)

land_use <-density(ppp_landuse,sigma=300,eps=c(50,50))
r_landuse <- raster(land_use,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_landuse,'landuse.tif',options=c('TFW=YES'))
