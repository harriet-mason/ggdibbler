# load libraries
library(vdiffr)
library(ggplot2)
library(dplyr)
library(sf)

# Compute data
basic_data <- toy_temp_dist |>
  filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County", "Harrison County"))

# test geom
test_that("geom_sf_sample tests", {
  set.seed(1)
  
  # basic geom_sf check
  p1 <- basic_data |>  
    ggplot2::ggplot() + 
    geom_sf_sample(ggplot2::aes(geometry = county_geometry, fill=temp_dist), times=9)
  vdiffr::expect_doppelganger("basic sample check", p1)

  # check layering with sf is fine
  p2 <- basic_data |>
    ggplot2::ggplot() +
    geom_sf_sample(ggplot2::aes(geometry = county_geometry, fill=temp_dist), times=9) +
    ggplot2::geom_sf(ggplot2::aes(geometry=county_geometry), fill=NA, linewidth=1)
  vdiffr::expect_doppelganger("layering sf sample check", p2)
  
  # check with different times
  p3 <- basic_data |>  
    ggplot2::ggplot() + 
    geom_sf_sample(ggplot2::aes(geometry = county_geometry, fill=temp_dist), times=12)
  vdiffr::expect_doppelganger("n change sample check", p3)
  
  # check with palette change
  p4 <- basic_data |>  
    ggplot2::ggplot() + 
    geom_sf_sample(ggplot2::aes(geometry = county_geometry, fill=temp_dist), times=9) +
    ggplot2::scale_fill_viridis_c()
  vdiffr::expect_doppelganger("pal change sample check", p4)
}
)
