# Processing for space syntax calculations and land-use

Python script for downloading land-use from OSM (https://www.openstreetmap.org/):
   - [osm_overpass_api.py](https://github.com/maryandplus/space_syntax_scripts_thesis/blob/master/osm_overpass_api.py)

R scripts must be used in this order*:

  - [kde_spacesyntax_values.R](https://github.com/maryandplus/space_syntax_scripts_thesis/blob/master/kde_spacesyntax_values.R) - For KDE and saving produced raster layers 
  - [mask_kde_raster_layers.R](https://github.com/maryandplus/space_syntax_scripts_thesis/blob/master/mask_kde_raster_layers.R) - For masking the raster layers and chossing only positive values 
  - [pair_plot_zonal_statistics.R](https://github.com/maryandplus/space_syntax_scripts_thesis/blob/master/pair_plot_zonal_statistics.R) - For a quick overview of the data
  - [KDC_spatial_correlation.R](https://github.com/maryandplus/space_syntax_scripts_thesis/blob/master/KDC_spatial_correlation.R) - For KDC and spatial correlation 

*Input datasets are space syntax calculations in point data and land-use point data downloaded from OSM.
  
  

