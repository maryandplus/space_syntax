#load libraries
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(sf)
library(dplyr)
library(raster)
library(readr)

#load raster layers - correlation maps

ch400 <- raster("ch400_posvalues.tif")
ch800 <- raster("ch800_posvalues.tif")
ch1600 <- raster("ch1600_posvalues.tif")
ch2400 <- raster("ch2400_posvalues.tif")
ch10k <- raster("ch10k_posvalues.tif")
landuse <- raster("landuse_posvalues.tif")


# #load vector layer - centers in study area
urban_areas <- st_read(dsn="../centers_urbanareas.shp", layer="centers_urbanareas",options = "ENCODING=WINDOWS-1252")
st_crs(urban_areas) <- 25832
urban_areas


#create pair plot
forpair<- stack(ch400,ch800,ch1600,ch2400,ch10k,landuse)
names(forpair) <- c("AC400","AC800","AC1600","AC2400","AC10000","LU")
pairs(values(forpair), hist=FALSE, cor=FALSE)







#zonal statistics

s <- stack(ch400_LU,ch800_LU,ch1600_LU,ch2400_LU,ch10k_LU)

extract_mean <- extract(s, urban_areas, fun='mean', na.rm=TRUE, df=TRUE)
df_withID <- data.frame(ID=urban_areas$id_new, extract_mean)

merged_urban_areas<- inner_join(urban_areas,df_withID,c("id_new" = "ID"))
st_write(merged_urban_areas, dsn='merged_urban_areas.shp',layer='merged_urban_areas')



