# VSUP geom_sf
geom_sf_VSUP <- function(ggplot, ???){
  ggplot +
    geom_sf(aes(fill = ???, geometry = geometry), colour=NA) + 
    scale_fill_manual(values = VSUP)
}
# write up similarly to geom_sf but with VSUP
  