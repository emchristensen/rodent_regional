# rodent_regional

## Files
**get_portal_rodent_data.R** - code for downloading version 1.115.0 of the PortalData collection and extracting data wanted for this project

**portal_rodent_controlplots_1977_2017.csv** - rodent capture data; output of "get_portal_rodent_data.R"

**portal_trapping_effort_1977_2017.csv** - trapping effort; output of "get_portal_rodent_data.R"

## Google earth engine to get NDVI:

**gee_code_landsat5_SR_NDVI_Portal.txt** - code used in GEE to extract NDVI for area around Portal

**Landsat5_SR_NDVI_Portal_1995_2006.csv** - NDVI data around Portal 1995-2006 derived from Landsat5 Surface Reflectance data

**Landsat5_SR_NDVI_Portal_2004_2013.csv** - NDVI data around Portal 2004-2013 derived from Landsat5 Surface Reflectance data

Processing Steps
 - get landsat images that intersect with study area
 - calculate and apply cloud mask (works, but ee.Algorithms.Landsat.simpleCloudScore is not the best method)
 - calculate ndvi as additional band
 - calculate mean ndvi for each image
 - export table of mean ndvi



Resources I used for GEE:
https://developers.google.com/earth-engine/exporting

Schmid thesis: https://www.researchgate.net/publication/320708352_Using_Google_Earth_Engine_for_Landsat_NDVI_time_series_analysis_to_indicate_the_present_status_of_forest_stands

Cloud masking:
https://developers.google.com/earth-engine/landsat
