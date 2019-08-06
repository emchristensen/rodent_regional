# rodent_regional
<<<<<<< HEAD

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
=======
Code for manipulating the Portal data for the regional rodent project.

## Files
**get_portal_rodent_data.R** - code for downloading version 1.115.0 of the PortalData collection and extracting data wanted for this project

**portal_rodent_controlplots_1977_2017.csv** - rodent capture data; output of "get_portal_rodent_data.R"

**portal_trapping_effort_1977_2017.csv** - trapping effort; output of "get_portal_rodent_data.R"
>>>>>>> e1cee03979a4e93a1cf4d73e71e9026a7b279bb3
