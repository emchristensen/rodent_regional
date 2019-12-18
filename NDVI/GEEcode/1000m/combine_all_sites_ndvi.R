# Combine NDVI from the various sites into one data frame
# EMC 12/18/19

library(dplyr)

#' @description NDVI data from google earth engine: get date information from system.index and create date column
#' 
#' @param ndviframe data frame of raw ndvi data from google earth engine
get_date_from_index = function(ndviframe) {
  ndviframe$year = substr(ndviframe$system.index,13,16)
  ndviframe$month = substr(ndviframe$system.index,17,18)
  ndviframe$day = substr(ndviframe$system.index,19,20)
  ndviframe$date = as.Date(paste(ndviframe$year, ndviframe$month, ndviframe$day, sep='-'))
  return(ndviframe)
}

#' @description process an individual ndvi file, including removing values where cloud cover was above a defined threshhold
#' 
#' @param ndviframe data frame of raw ndvi data from google earth engine
#' @param min_pct_pixel_coverage minimum % clear pixels in order to keep the data from the image
process_individual_ndvi_file = function(ndviframe, min_pct_pixel_coverage) {
  totalpixels = max(ndviframe$NDVI_count)
  # remove data points where there aren't enough good pixels, or if NDVI_mean is <0
  ndviframe$NDVI_mean[ndviframe$NDVI_count<(totalpixels*min_pct_pixel_coverage)] <- NA
  ndviframe$NDVI_mean[ndviframe$NDVI_mean<0] <- NA
  
  ndviframe2 = ndviframe %>%
    dplyr::select(year, month, NDVI_mean) %>%
    group_by(year, month) %>%
    summarize(NDVI = mean(NDVI_mean, na.rm=T))
  
  return(ndviframe2)
}

min_pct_pixel_coverage = .75

# =======================================
# combine all 1995-2006 timeseries
jrn1 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_JRN_ecotone3_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_ecotone3 = NDVI)
jrn2 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_JRN_ecotone9_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_ecotone9 = NDVI)
jrn3 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_JRN_ecotone12_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_ecotone12 = NDVI)
jrn4 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_JRN_SMES_blackgrama_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_SMES_blackgrama = NDVI)
jrn5 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_JRN_SMES_creosote_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_SMES_creosote = NDVI)
por = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_Portal_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                Portal = NDVI)
sev1 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_5pgrass_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_5pgrass = NDVI)
sev2 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_5plarrea_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_5plarrea = NDVI)
sev3 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_blugrama_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_blugrama = NDVI)
sev4 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_goatdraw_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_goatdraw = NDVI)
sev5 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_rsgrass_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_rsgrass = NDVI)
sev6 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_rslarrea_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_rslarrea = NDVI)
sev7 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_savanna_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_savanna = NDVI)
sev8 = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SEV_two22_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_two22 = NDVI)
sgs = read.csv('NDVI/GEEcode/1000m/Landsat5_SR_NDVI_SGS_1995_2006.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SGS = NDVI)

ndvi_1995_2006 = merge(jrn1, por, by=c('year','month'), all=T) %>%
  merge(jrn2, all=T) %>%
  merge(jrn3, all=T) %>%
  merge(jrn4, all=T) %>%
  merge(jrn5, all=T) %>%
  merge(por, all=T) %>%
  merge(sev1, all=T) %>%
  merge(sev2, all=T) %>%
  merge(sev3, all=T) %>%
  merge(sev4, all=T) %>%
  merge(sev5, all=T) %>%
  merge(sev6, all=T) %>%
  merge(sev7, all=T) %>%
  merge(sev8, all=T) %>%
  merge(sgs)

write.csv(ndvi_1995_2006, 'NDVI/ndvi_1995_2006.csv', row.names = F)

# =======================================
# combine all 2004-2013 timeseries
jrn1b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_JRN_ecotone3_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_ecotone3 = NDVI)
jrn2b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_JRN_ecotone9_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_ecotone9 = NDVI)
jrn3b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_JRN_ecotone12_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_ecotone12 = NDVI)
jrn4b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_JRN_SMES_blackgrama_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_SMES_blackgrama = NDVI)
jrn5b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_JRN_SMES_creosote_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                JRN_SMES_creosote = NDVI)
porb = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_Portal_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                Portal = NDVI)
sev1b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_5pgrass_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_5pgrass = NDVI)
sev2b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_5plarrea_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_5plarrea = NDVI)
sev3b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_blugrama_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_blugrama = NDVI)
sev4b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_goatdraw_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_goatdraw = NDVI)
sev5b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_rsgrass_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_rsgrass = NDVI)
sev6b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_rslarrea_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_rslarrea = NDVI)
sev7b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_savanna_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_savanna = NDVI)
sev8b = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SEV_two22_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SEV_two22 = NDVI)
sgsb = read.csv('NDVI/GEEcode/1000m/Landsat7_SR_NDVI_SGS_2004_2013.csv', stringsAsFactors = F) %>%
  get_date_from_index() %>%
  process_individual_ndvi_file(min_pct_pixel_coverage = min_pct_pixel_coverage) %>%
  dplyr::select(year, month,
                SGS = NDVI)

ndvi_2004_2013 = merge(jrn1b, porb, by=c('year','month'), all=T) %>%
  merge(jrn2b, all=T) %>%
  merge(jrn3b, all=T) %>%
  merge(jrn4b, all=T) %>%
  merge(jrn5b, all=T) %>%
  merge(sev1b, all=T) %>%
  merge(sev2b, all=T) %>%
  merge(sev3b, all=T) %>%
  merge(sev4b, all=T) %>%
  merge(sev5b, all=T) %>%
  merge(sev6b, all=T) %>%
  merge(sev7b, all=T) %>%
  merge(sev8b, all=T) %>%
  merge(sgsb)

write.csv(ndvi_2004_2013, 'NDVI/ndvi_2004_2013.csv', row.names = F)
