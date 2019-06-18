#' This script is to extract time series rodent data from the Portal database
#' We only want October data, for comparison to LTER-collected rodent data
#' EMC 6/18/19

library(portalr)
library(tidyverse)

# version 1.115.0
data_tables <- load_rodent_data('.')

rodent_abundance_by_plot <- abundance(path='.', time='date', level='plot')
rodent_abundance <- rodent_abundance_by_plot %>%
  gather(species, abundance, -censusdate, -treatment, -plot) 

rodent_abundance$month <- lubridate::month(rodent_abundance$censusdate)
rodent_abundance$year <- lubridate::year(rodent_abundance$censusdate)


# filter data
portal_octobers <- rodent_abundance %>%
  dplyr::filter(month %in% 9:11, treatment=='control', year>1978)
