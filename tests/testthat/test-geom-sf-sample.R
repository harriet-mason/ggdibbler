# load libraries
library(vdiffr)
library(ggplot2)
library(dplyr)
library(sf)

# Compute data
basic_data <- toy_temp_dist |>
  filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County"))

# test geom
test_that("geom_sf_sample tests", {
  set.seed(1443)
  
  p1 <-  basic_data |>
    ggplot() +
    geom_sf_sample(times=100, linewidth=0,
                   aes(geometry = county_geometry, fill=temp_dist))
  expect_doppelganger("Example 1", p1)
  
  p2 <- basic_data |>
    ggplot() +
    geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist), 
                   linewidth=0, times=100) +
    scale_fill_viridis_c() + 
    geom_sf(aes(geometry=county_geometry), fill=NA, linewidth=1)
  expect_doppelganger("Example 2", p2)
  
}
)



