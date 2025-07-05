# testing sf stuff to find debug
toydata <- toy_temp_dist |>
  dplyr::filter(county_name %in% c("Story County", "Boone County", "Johnson County"))

# data with matching names for checking compute_group functions
named <- toydata |>
  dplyr::rename(fill = temp_dist,
                geometry = county_geometry) |>
  dplyr::select(geometry, fill)

StatSample$compute_panel(named, coord=coord_sf(default = TRUE))

# No idea what this is. Maybe check subdivide by itself first.