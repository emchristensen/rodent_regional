#' This script is to extract time series rodent data from the Portal database
#' We only want October data, for comparison to LTER-collected rodent data
#' Description of methods can be found at: https://www.biorxiv.org/content/10.1101/332783v1.abstract
#'    or in the github repo: https://github.com/weecology/PortalData
#  Erica Christensen echriste@nmsu.edu
# 6/21/19

library(portalr)
library(tidyverse)

# download/load data: version 1.115.0
data_tables <- load_rodent_data(path='.')

rodent_data = data_tables$rodent_data
plots_table = data_tables$plots_table
species_table = data_tables$species_table

# merge rodent data with support tables
rodent_plots = merge(rodent_data, plots_table[,c('year','month','plot','treatment')], 
                     by=c('year','month','plot'), all.x=T) %>%
  merge(species_table[,c('species','scientificname','censustarget')], by='species', all.x=T)


# filter for: only control plots, only target species, only October censuses
portal_octobers = rodent_plots %>%
  dplyr::filter(treatment=='control', month==10, censustarget==1) %>%
  dplyr::select(recordID, year, month, day, period, plot, treatment, note1, stake, species, 
                scientificname, sex, reprod, age, testes, vagina, pregnant, nipples, lactation,
                hfl, wgt, tag, note2, ltag, note3, prevrt, prevlet, nestdir, neststk, note4, note5) %>%
  dplyr::arrange(period, plot)

# write to csv
write.csv(portal_octobers, "portal_rodent_controlplots_1977_2017.csv")
