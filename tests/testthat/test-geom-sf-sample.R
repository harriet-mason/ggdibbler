# load libraries
library(vdiffr)
library(ggplot2)
library(dplyr)
library(sf)

# Compute data
basic_data <- toy_temp_dist |>
  filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County"))

# Make data for null test
# get CRS
my_crs <- st_crs(toy_temp_dist$county_geometry)
# make null row with empty geometry
null_row <- tibble(county_name = "None",
                   temp_dist = distributional::dist_normal(29,1),
                   county_geometry = st_sfc(st_multipolygon(), crs = my_crs)) |>
  st_sf()

# Combine with toytemp data
null_test <- basic_data |>
  rbind(null_row)


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
  
  p3 <- null_test |>
    ggplot() +
    geom_sf_sample(times=100, linewidth=0,
                   aes(geometry = county_geometry, fill=temp_dist))
  expect_doppelganger("Empty Geometry", p3)
  
}
)


