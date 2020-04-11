#load libraries
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(dplyr)
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

#integration 
int400 <- raster("int400.tif")
int800 <- raster("int800.tif")
int1600 <- raster("int1600.tif")
int2400 <- raster("int2400.tif")
int10k <- raster("int10k.tif")

#landuse
landuse <- raster("landuse.tif")



#use sea mask
coastline <- st_read(dsn="xxXxxxXX/dissolved_polygonize.shp", layer="dissolved_polygonize")

maskedlanduse<- mask(x= landuse,mask=coastline)

maskedch400<- mask(x= ch400,mask=coastline)
maskedint400<- mask(x= int400,mask=coastline)

maskedch800<- mask(x= ch800,mask=coastline)
maskedint800<- mask(x= int800,mask=coastline)

maskedch1600<- mask(x= ch1600,mask=coastline)
maskedint1600<- mask(x= int1600,mask=coastline)

maskedch2400<- mask(x= ch2400,mask=coastline)
maskedint2400<- mask(x= int2400,mask=coastline)

maskedch10k<- mask(x= ch10k,mask=coastline)
maskedint10k<- mask(x= int10k,mask=coastline)


#resample landuse
landuse_resampled <- resample(maskedlanduse,ch400,method='bilinear')


#remove values below zero
landuse_resampled[landuse_resampled<0] <- NA
ch400[ch400<0] <- NA
int400[int400<0] <- NA

ch800[ch800<0] <- NA
int800[int800<0] <- NA

ch1600[ch1600<0] <- NA
int1600[int1600<0] <- NA

ch2400[ch2400<0] <- NA
int2400[int2400<0] <- NA

ch10k[ch10k<0] <- NA
int10k[int10k<0] <- NA

#save rasters
writeRaster(landuse_resampled,'landuse_posvalues.tif',options=c('TFW=YES'))

writeRaster(ch400,'ch400_posvalues.tif',options=c('TFW=YES'))
writeRaster(int400,'int400_posvalues.tif',options=c('TFW=YES'))

writeRaster(ch800,'ch800_posvalues.tif',options=c('TFW=YES'))
writeRaster(int800,'int800_posvalues.tif',options=c('TFW=YES'))

writeRaster(ch1600,'ch1600_posvalues.tif',options=c('TFW=YES'))
writeRaster(int1600,'int1600_posvalues.tif',options=c('TFW=YES'))

writeRaster(ch2400,'ch2400_posvalues.tif',options=c('TFW=YES'))
writeRaster(int2400,'int2400_posvalues.tif',options=c('TFW=YES'))

writeRaster(ch10k,'ch10k_posvalues.tif',options=c('TFW=YES'))
writeRaster(int10k,'int10k_posvalues.tif',options=c('TFW=YES'))


plot(ch400)
plot(ch800)
plot(ch1600)
plot(ch2400)
plot(ch10k)

plot(int400)
plot(int800)
plot(int1600)
plot(int2400)
plot(int10k)
