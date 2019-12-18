## NDVI
Used Google Earth Engine to obtain Landsat data for all sites. I decided to use the Surface Reflectance Tier 1 product and calculate NDVI from the bands myself, because the NDVI products don't contain a pixel qa layer. See compare_sr_ndvi_products.html for comparison of products.

**GEEcode** - folder containing google earth engine code used and raw output from that code. Only code for the Portal site is included, but the code can be applied to the other sites by changing the GPS coordinates in line 10.

**oldcode** - folder containing old scripts, not the final versions

**ndvi_1995_2006.csv** - monthly ndvi for all locations 1995-2006 (Landsat5)

**ndvi_2004_2013.csv** - monthly ndvi for all locations 2004-2013 (Landsat7)

**plot_NDVI.R** - R code for plotting ndvi as time series

## Processing Steps
1. Run code in gee_NDVI_Landsat_SR_Portal.txt in google earth engine (requires login). This script does the following:
 - get landsat images that intersect with study area (1000m radius around trapping points)
 - calculate and apply cloud mask using qa band (see Examples > Cloud Masking > Landsat457 in GEE scripts)
 - calculate ndvi as additional band (using normalizedDifference function in GEE)
 - calculate mean ndvi for each image
 - export table of mean ndvi
2. Replace the coordinates in the Portal file with the other sites and run. Place output csv files in 1000m folder.
3. Run combine_all_sites_ndvi.R to create final monthly ndvi files


Resources I used for GEE:
https://developers.google.com/earth-engine/exporting

Schmid thesis: https://www.researchgate.net/publication/320708352_Using_Google_Earth_Engine_for_Landsat_NDVI_time_series_analysis_to_indicate_the_present_status_of_forest_stands

Cloud masking:
https://developers.google.com/earth-engine/landsat
