#' This script is to extract time series rodent data from the Portal database
#' We only want October data, for comparison to LTER-collected rodent data
#' Description of methods can be found at: https://www.biorxiv.org/content/10.1101/332783v1.abstract
#'    or in the github repo: https://github.com/weecology/PortalData
#  Erica Christensen echriste@nmsu.edu
# 6/21/19

library(portalr)
library(tidyverse)
library(lubridate)

# download/load data: version 1.115.0
download_observations("./PortalDatav115", version = "1.115.0")
data_tables <- load_rodent_data(path='./PortalDatav115')

rodent_data <- data_tables$rodent_data
species_table <- data_tables$species_table
trapping_table <- data_tables$trapping_table

# this analysis will be restricted to only the 4 plots that have been controls for the entire experiment 1977-2017
selected_plots = c(4,11,14,17)

# find select census dates: closest census to October 15 for each year
#  create date column
trapping_table$date = as.Date(paste(trapping_table$year, trapping_table$month, trapping_table$day, sep='-'))
#  create table of first date of trapping for each period
trapping_dates = trapping_table %>%
  dplyr::select(period, date) %>%
  dplyr::group_by(period) %>%
  dplyr::summarise(date = min(date),
            year = lubridate::year(date),
            october= as.Date(paste(year,'10','15',sep='-')),
            datediff=abs(date-october))
#  identify trapping period closest to Oct 15 for each year
selected_periods = trapping_dates %>%
  dplyr::group_by(year) %>%
  dplyr::slice(which.min(datediff))

# extract trapping info [only selected plots and periods]
portal_octobers_trapping = trapping_table %>%
  dplyr::filter(period %in% selected_periods$period,
                plot %in% selected_plots,
                sampled==1,
                year<=2017) %>%
  dplyr::group_by(period, year) %>%
  dplyr::summarize(num_plots=length(unique(plot)),
                   num_traps=sum(effort))

# extract rodent capture data [only selected plots and periods]
portal_octobers_rodents = rodent_data %>%
  merge(species_table[,c('species','scientificname','censustarget')], by='species', all.x=T) %>%
  dplyr::filter(censustarget==1,
                plot %in% selected_plots,
                period %in% selected_periods$period,
                year<=2017) %>%
  dplyr::select(-censustarget)
  dplyr::arrange(recordID)

# write to csv
write.csv(portal_octobers_rodents, "portal_rodent_controlplots_1977_2017.csv", row.names=F)
write.csv(portal_octobers_trapping, "portal_trapping_effort_1977_2017.csv", row.names=F)
