#load libraries
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(sf)
library(dplyr)
library(spatstat)
library(maptools)
library(rgdal)
library(raster)
library(readr)
library(mapview)
library(rasterVis)

#data preparation 
#load rasters


#load layers after data preparation

ch400 <- raster("ch400_posvalues.tif")
ch800 <- raster("ch800_posvalues.tif")
ch1600 <- raster("ch1600_posvalues.tif")
ch2400 <- raster("ch2400_posvalues.tif")
ch10k <- raster("ch10k_posvalues.tif")



landuse <- raster("landuse_posvalues.tif")



ch400[ch400==0] <-NA
ch800[ch800==0] <-NA
ch1600[ch1600==0] <-NA
ch2400[ch2400==0] <-NA
ch400[ch10k==0] <-NA



# stack covariates

#choice 400 - landuse
stackedch400 <- stack(ch400, landuse)
names(stackedch400) <- c("ch400", "landuse")

#Calculate local correlation using focal on two rasters at the same time
stackedch400_nb <- raster(stackedch400, 1)
values(stackedch400_nb) <- 1:ncell(stackedch400)

matrix_stackedch400 <- values(stackedch400) # stack as raster 

cor_stackedch400 <- focal(
  x = stackedch400_nb,
  w = matrix(1, 5, 5),
  fun = function(x, y = matrix_stackedch400){ 
    cor(y[x, 1], y[x, 2], # [MW]
        use = "na.or.complete", method="spearman")
  },
  filename = ("correlations/cor_stackedch400spr.tif"),
  overwrite = TRUE
)

plot(cor_stackedch400)





#choice 800 - landuse
stackedch800 <- stack(ch800, landuse)
names(stackedch800) <- c("ch800", "landuse")
cor(values(stackedch800)[,1],values(stackedch800)[,2],use = "na.or.complete", method="spearman")




#Calculate local correlation using focal on two rasters at the same time
stackedch800_nb <- raster(stackedch800, 1)
values(stackedch800_nb) <- 1:ncell(stackedch800)

matrix_stackedch800 <- values(stackedch800) # stack as raster 

cor_stackedch800 <- focal(
  x = stackedch800_nb,
  w = matrix(1, 5, 5),
  fun = function(x, y = matrix_stackedch800){ 
    cor(y[x, 1], y[x, 2], # [MW]
        use = "na.or.complete", method="spearman")
  },
  filename = ("correlations/cor_stackedch800.tif"),
  overwrite = TRUE
)

plot(cor_stackedch800)





#choice 1600 - landuse
stackedch1600 <- stack(ch1600, landuse)
names(stackedch1600) <- c("ch1600", "landuse")
cor(values(stackedch1600)[,1],values(stackedch1600)[,2],use = "na.or.complete", method="spearman")



#Calculate local correlation using focal on two rasters at the same time
stackedch1600_nb <- raster(stackedch1600, 1)
values(stackedch1600_nb) <- 1:ncell(stackedch1600)

matrix_stackedch1600 <- values(stackedch1600) # stack as raster 

cor_stackedch1600 <- focal(
  x = stackedch1600_nb,
  w = matrix(1, 5, 5),
  fun = function(x, y = matrix_stackedch1600){ 
    cor(y[x, 1], y[x, 2], # [MW]
        use = "na.or.complete", method="spearman")
  },
  filename = ("correlations/cor_stackedch1600.tif"),
  overwrite = TRUE
)

plot(cor_stackedch1600)







#choice 2400 - landuse
stackedch2400 <- stack(ch2400, landuse)
names(stackedch2400) <- c("ch2400", "landuse")
cor(values(stackedch2400)[,1],values(stackedch2400)[,2],use = "na.or.complete", method="spearman")



#Calculate local correlation using focal on two rasters at the same time
stackedch2400_nb <- raster(stackedch2400, 1)
values(stackedch2400_nb) <- 1:ncell(stackedch2400)

matrix_stackedch2400 <- values(stackedch2400) # stack as raster 

cor_stackedch2400 <- focal(
  x = stackedch2400_nb,
  w = matrix(1, 5, 5),
  fun = function(x, y = matrix_stackedch2400){ 
    cor(y[x, 1], y[x, 2], # [MW]
        use = "na.or.complete", method="spearman")
  },
  filename = ("correlations/cor_stackedch2400.tif"),
  overwrite = TRUE
)

plot(cor_stackedch2400)




#choice 10k - landuse
stackedch10k <- stack(ch10k, landuse)
names(stackedch10k) <- c("ch10k", "landuse")
cor(values(stackedch10k)[,1],values(stackedch10k)[,2],use = "na.or.complete", method="spearman")


#Calculate local correlation using focal on two rasters at the same time
stackedch10k_nb <- raster(stackedch10k, 1)
values(stackedch10k_nb) <- 1:ncell(stackedch10k)

matrix_stackedch10k <- values(stackedch10k) # stack as raster 

cor_stackedch10k <- focal(
  x = stackedch10k_nb,
  w = matrix(1, 5, 5),
  fun = function(x, y = matrix_stackedch10k){ 
    cor(y[x, 1], y[x, 2], # [MW]
        use = "na.or.complete", method="spearman")
  },
  filename = ("correlations/cor_stackedch10k.tif"),
  overwrite = TRUE
)

plot(cor_stackedch10k)


#mask lakes and coastline
coastline <- st_read(dsn="../kommuner_final.shp", layer="kommuner_final")
st_crs(coastline) <- 25832
lakes <- st_read(dsn="../lakes.shp", layer="lakes")
st_crs(lakes) <- 25832
e_lakes <- st_zm(lakes,drop = TRUE, what = "ZM")




cor_maskch400<- mask(x= cor_stackedch400,mask=coastline)
cor_maskch400_2<- mask(x= cor_maskch400,mask=e_lakes, inverse=TRUE)

cor_maskch800<- mask(x= cor_stackedch800,mask=coastline)
cor_maskch800_2<- mask(x= cor_maskch800,mask=e_lakes, inverse=TRUE)


cor_maskch1600<- mask(x= cor_stackedch1600,mask=coastline)
cor_maskch1600_2<- mask(x= cor_maskch1600,mask=e_lakes, inverse=TRUE)

cor_maskch2400<- mask(x= cor_stackedch2400,mask=coastline)
cor_maskch2400_2<- mask(x= cor_maskch2400,mask=e_lakes, inverse=TRUE)

cor_maskch10k<- mask(x= cor_stackedch10k,mask=coastline)
cor_maskch10k_2<- mask(x= cor_maskch10k,mask=e_lakes, inverse=TRUE)

#save raster layers
writeRaster(cor_maskch400_2,'correlations/masked/cor_maskch400_2.tif',options=c('TFW=YES'),overwrite = TRUE)
writeRaster(cor_maskch800_2,'correlations/masked/cor_maskch800_2.tif',options=c('TFW=YES'),overwrite = TRUE)
writeRaster(cor_maskch1600_2,'correlations/masked/cor_maskch1600_2.tif',options=c('TFW=YES'),overwrite = TRUE)
writeRaster(cor_maskch2400_2,'correlations/masked/cor_maskch2400_2.tif',options=c('TFW=YES'),overwrite = TRUE)
writeRaster(cor_maskch10k_2,'correlations/masked/cor_maskch10k_2.tif',options=c('TFW=YES'),overwrite = TRUE)


#correlations of raster layers
cor(values(stackedch400)[,1],values(stackedch400)[,2],use = "na.or.complete", method="spearman")
cor(values(stackedch800)[,1],values(stackedch800)[,2],use = "na.or.complete", method="spearman")
cor(values(stackedch1600)[,1],values(stackedch1600)[,2],use = "na.or.complete", method="spearman")
cor(values(stackedch2400)[,1],values(stackedch2400)[,2],use = "na.or.complete", method="spearman")
cor(values(stackedch10k)[,1],values(stackedch10k)[,2],use = "na.or.complete", method="spearman")
