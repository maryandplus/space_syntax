#load libraries
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(sf)
library(dplyr)
library(spatstat)
library(maptools)
library(rgdal)
library(raster)

#data preparation 
#load rasters

#choice 
ch400 <- raster("ch400.tif")
ch800 <- raster("ch800.tif")
ch1600 <- raster("ch1600.tif")
ch2400 <- raster("ch2400.tif")
ch10k <- raster("ch10k.tif")


#landuse
landuse <- raster("landuse.tif")



#use coastline and lakes
coastline <- st_read(dsn="../kommuner_final.shp", layer="kommuner_final")
st_crs(coastline) <- 25832 
lakes <- st_read(dsn="../lakes.shp", layer="lakes")
st_crs(lakes) <- 25832 
e_lakes <- st_zm(lakes,drop = TRUE, what = "ZM")
maskedlanduse<- mask(x= landuse,mask=coastline)
maskedlanduse2<- mask(x= maskedlanduse,mask=e_lakes, inverse=TRUE)

maskedch400<- mask(x= ch400,mask=coastline)
maskedch400_2<- mask(x= maskedch400,mask=e_lakes, inverse=TRUE)


maskedch800<- mask(x= ch800,mask=coastline)
maskedch800_2<- mask(x= maskedch800,mask=e_lakes, inverse=TRUE)


maskedch1600<- mask(x= ch1600,mask=coastline)
maskedch1600_2<- mask(x= maskedch1600,mask=e_lakes, inverse=TRUE)


maskedch2400<- mask(x= ch2400,mask=coastline)
maskedch2400_2<- mask(x= maskedch2400,mask=e_lakes, inverse=TRUE)


maskedch10k<- mask(x= ch10k,mask=coastline)
maskedch10k_2<- mask(x= maskedch10k,mask=e_lakes, inverse=TRUE)



#resample landuse
landuse_resampled <- resample(maskedlanduse2,ch400,method='bilinear')


#remove values below zero
landuse_resampled[landuse_resampled<0] <- NA
maskedch400_2[maskedch400_2<0] <- NA
maskedch800_2[maskedch800_2<0] <- NA
maskedch1600_2[maskedch1600_2<0] <- NA
maskedch2400_2[maskedch2400_2<0] <- NA
maskedch10k_2[maskedch10k_2<0] <- NA


#save raster layers
writeRaster(landuse_resampled,'landuse_posvalues.tif',options=c('TFW=YES'))

writeRaster(maskedch400_2,'ch400_posvalues.tif',options=c('TFW=YES'))
writeRaster(maskedch800_2,'ch800_posvalues.tif',options=c('TFW=YES'))
writeRaster(maskedch1600_2,'ch1600_posvalues.tif',options=c('TFW=YES'))
writeRaster(maskedch2400_2,'ch2400_posvalues.tif',options=c('TFW=YES'))
writeRaster(maskedch10k_2,'ch10k_posvalues.tif',options=c('TFW=YES'))
