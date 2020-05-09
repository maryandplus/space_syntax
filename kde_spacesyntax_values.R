#try kde for points
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(sf)
library(dplyr)
library(spatstat)
library(maptools)
#read and view road network shapefile
kob_network.sf <-st_read(dsn="../network_vertices.shp", layer="network_vertices")
st_crs(kob_network.sf) <- 25832 


#create point pattern from sf
ppp_network <- as.ppp(kob_network.sf$geometry)




library(raster)
#KDE angular choice
ch400 <-density(ppp_network,sigma=300,eps=c(100,100), weights = kob_network.sf$AC_w400)
r_ch400 <- raster(ch400,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch400,'ch400.tif',options=c('TFW=YES'))

ch800 <-density(ppp_network,sigma=300,eps=c(100,100), weights = kob_network.sf$AC_w800)
r_ch800 <- raster(ch800,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch800,'ch800.tif',options=c('TFW=YES'))

ch1600 <-density(ppp_network,sigma=300,eps=c(100,100), weights = kob_network.sf$AC_w1600)
r_ch1600 <- raster(ch1600,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch1600,'ch1600.tif',options=c('TFW=YES'))

ch2400 <-density(ppp_network,sigma=300,eps=c(100,100), weights = kob_network.sf$AC_w2400)
r_ch2400 <- raster(ch2400,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch2400,'ch2400.tif',options=c('TFW=YES'))

ch10k <-density(ppp_network,sigma=300,eps=c(100,100), weights = kob_network.sf$AC_w10k)
r_ch10k <- raster(ch10k,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_ch10k,'ch10k.tif',options=c('TFW=YES'))




#land use points
osm_points.sf <- st_read(dsn="../osm_kob_all.shp", layer="osm_kob_all")
st_crs(osm_points.sf) <- 25832 
ppp_landuse <- as.ppp(osm_points.sf$geometry)

land_use <-density(ppp_landuse,sigma=300,eps=c(100,100))
r_landuse <- raster(land_use,crs='+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
writeRaster(r_landuse,'landuse.tif',options=c('TFW=YES'))

