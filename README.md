# rodent_regional

### Google earth engine:
Steps
 - get landsat collection (works)
 - calculate and apply cloud mask (works, but ee.Algorithms.Landsat.simpleCloudScore is not the best method)
 - calculate ndvi as additional band (works)
 - calculate mean ndvi for each image (works? but can't figure out how to get date attached to featurecollection)
 - export table of mean ndvi (works! writes to my google drive)



Resources I used for GEE:
https://developers.google.com/earth-engine/exporting
Schmid thesis: https://www.researchgate.net/publication/320708352_Using_Google_Earth_Engine_for_Landsat_NDVI_time_series_analysis_to_indicate_the_present_status_of_forest_stands

Cloud masking:
https://developers.google.com/earth-engine/landsat