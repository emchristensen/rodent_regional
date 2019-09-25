## NDVI
Used Google Earth Engine to obtain Landsat5 data for all sites.

**GEEcode** - folder containing google earth engine code used and raw output from that code

**oldcode** - folder containing old scripts, not the final versions

**ndvi_1995_2006.csv** - monthly ndvi for all locations 1995-2006

**ndvi_2004_2013.csv** - monthly ndvi for all locations 2004-2013

**plot_NDVI.R** - R code for plotting ndvi as time series

## Processing Steps
 - get landsat images that intersect with study area (1000m radius around trapping points)
 - calculate and apply cloud mask (works, but ee.Algorithms.Landsat.simpleCloudScore is not the best method)
 - calculate ndvi as additional band
 - calculate mean ndvi for each image
 - export table of mean ndvi



Resources I used for GEE:
https://developers.google.com/earth-engine/exporting

Schmid thesis: https://www.researchgate.net/publication/320708352_Using_Google_Earth_Engine_for_Landsat_NDVI_time_series_analysis_to_indicate_the_present_status_of_forest_stands

Cloud masking:
https://developers.google.com/earth-engine/landsat
