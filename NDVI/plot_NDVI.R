#' This script plots NDVI data derived from google earth engine Landsat data
#' 
#' EMC 8/28/19

library(ggplot2)
library(dplyr)
library(cowplot)
library(tidyr)

ndvi1995 = read.csv('NDVI/ndvi_1995_2006.csv', stringsAsFactors = F)
ndvi1995$date = as.Date(paste(ndvi1995$year, ndvi1995$month, '15', sep='-'))

jrn = dplyr::select(ndvi1995, date, JRN_ecotone3, JRN_ecotone9, JRN_ecotone12, JRN_SMES_blackgrama, JRN_SMES_creosote) %>%
  gather(key='site', value='ndvi', JRN_ecotone3:JRN_SMES_creosote)

sev = dplyr::select(ndvi1995, date, SEV_5pgrass, SEV_5plarrea, SEV_blugrama, SEV_goatdraw, SEV_rsgrass, SEV_rslarrea, SEV_savanna, SEV_two22) %>%
  gather(key='site', value='ndvi', SEV_5pgrass:SEV_two22)

# =======================================
# plot individual sites time series
por = ggplot(filter(ndvi1995, !is.na(Portal)), aes(x=date, y=Portal)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('Portal')

sgs = ggplot(filter(ndvi1995, !is.na(SGS)), aes(x=date, y=SGS)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SGS')


jrn_3 = ggplot(filter(ndvi1995, !is.na(JRN_ecotone3)), aes(x=date, y=JRN_ecotone3)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('JRN: ecotone 3')
jrn_9 = ggplot(filter(ndvi1995, !is.na(JRN_ecotone9)), aes(x=date, y=JRN_ecotone9)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('JRN: ecotone 9')
jrn_12 = ggplot(filter(ndvi1995, !is.na(JRN_ecotone12)), aes(x=date, y=JRN_ecotone12)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('JRN: ecotone 12')
jrn_blackgrama = ggplot(filter(ndvi1995, !is.na(JRN_SMES_blackgrama)), aes(x=date, y=JRN_SMES_blackgrama)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('JRN: black grama')
jrn_creosote = ggplot(filter(ndvi1995, !is.na(JRN_SMES_creosote)), aes(x=date, y=JRN_SMES_creosote)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('JRN: creosote')

sev_5pgrass = ggplot(filter(ndvi1995, !is.na(SEV_5pgrass)), aes(x=date, y=SEV_5pgrass)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: 5pgrass')
sev_5plarrea = ggplot(filter(ndvi1995, !is.na(SEV_5plarrea)), aes(x=date, y=SEV_5plarrea)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: 5plarrea')
sev_blugrama = ggplot(filter(ndvi1995, !is.na(SEV_blugrama)), aes(x=date, y=SEV_blugrama)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: blugrama')
sev_goatdraw = ggplot(filter(ndvi1995, !is.na(SEV_goatdraw)), aes(x=date, y=SEV_goatdraw)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: goatdraw')
sev_rsgrass = ggplot(filter(ndvi1995, !is.na(SEV_rsgrass)), aes(x=date, y=SEV_rsgrass)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: rsgrass')
sev_rslarrea = ggplot(filter(ndvi1995, !is.na(SEV_rslarrea)), aes(x=date, y=SEV_rslarrea)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: rslarrea')
sev_savanna = ggplot(filter(ndvi1995, !is.na(SEV_savanna)), aes(x=date, y=SEV_savanna)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: savanna')
sev_two22 = ggplot(filter(ndvi1995, !is.na(SEV_two22)), aes(x=date, y=SEV_two22)) +
  geom_line() +
  ylab('NDVI') +
  xlab('') +
  ggtitle('SEV: two22')

# ==============================
# combine into multi-part plots and save
ggsave('NDVI/portal_ndvi.pdf',por, width = 5, height = 2)
ggsave('NDVI/sgs_ndvi.pdf', sgs, width=5, height=2)

jrn_comboplot = ggplot(jrn, aes(x=date, y=ndvi, color=site)) +
  geom_line()
jrn_comboplot
ggsave('NDVI/jrn_ndvi.pdf', jrn_comboplot, width=8, height=2)

sev_comboplot = ggplot(sev, aes(x=date, y=ndvi, color=site)) +
  geom_line()
sev_comboplot
ggsave('NDVI/sev_ndvi.pdf', sev_comboplot, width=8, height=2)
