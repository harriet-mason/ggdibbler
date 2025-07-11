# smaller test data for faster computations
basic_data <- toy_temp_dist |>
  dplyr::filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County", "Harrison County"))

# checks for subdivide function (had bug previously)
test_that("Subdivide tests", {
  # specific code for multipolygon bug
  sub_check <- subdivide(basic_data$county_geometry, d=3)
  sub_check_plot <- ggplot2::ggplot(sub_check) + ggplot2::geom_sf()
  vdiffr::expect_doppelganger("basic subdivide check", sub_check_plot)
}
)