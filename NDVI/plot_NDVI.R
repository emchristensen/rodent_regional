#' This script plots NDVI data derived from google earth engine Landsat data
#' 
#' EMC 8/28/19

library(ggplot2)
library(dplyr)

#' @title add date to NDVI
#' @description for data sets was derived from GEE (gee_code_landsat5_SR_Portal.txt), some processing is needed to extract date information
#' @param gee_dataset data frame; read from out put of GEE code
add_date_to_NDVI = function(gee_dataset) {
  gee_dataset$year = substr(gee_dataset$system.index, 13,16)
  gee_dataset$month = substr(gee_dataset$system.index, 17,18)
  gee_dataset$day = substr(gee_dataset$system.index, 19,20)
  gee_dataset$date = as.Date(paste(gee_dataset$year, gee_dataset$month, gee_dataset$day, sep='-'))
  
  return(gee_dataset)
}

# read in data 
portal1 = read.csv('NDVI/Landsat5_SR_NDVI_Portal_1995_2006.csv', stringsAsFactors = F)
portal1 = add_date_to_NDVI(portal1)

portal2 = read.csv('NDVI/Landsat5_SR_NDVI_Portal_2004_2013.csv', stringsAsFactors = F)
portal2 = add_date_to_NDVI(portal2)

# figures
ggplot(portal1, aes(x=date, y=NDVI)) +
  geom_line()

ggplot(portal2, aes(x=date, y=NDVI)) +
  geom_line()
