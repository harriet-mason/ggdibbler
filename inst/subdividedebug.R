
 devtools::load_all()

# check toy_temp_dist issue
library(ggplot2)

# issue starts at n=3, no issues for n=1 and n=2
# still exists if its just the one county

# Example 1
toy_temp_dist |>  
  dplyr::filter(county_name %in% c("Pottawattamie County")) |>
  ggplot() + 
  geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist), n=3)

# check subdivide function
# make data with just geometry
checkdata <- toy_temp_dist |>
  dplyr::filter(county_name %in% c("Pottawattamie County")) |>
  dplyr::rename(fill = temp_dist,
                geometry = county_geometry) |>
  dplyr::select(geometry, fill)

# check geometry made by subdivide
devtools::load_all()
sub_check <- subdivide(checkdata$geometry, d=3)
ggplot(sub_check) + geom_sf()

# Issue definitely in subdivide
# I think it might be areas that cross over the divide twice. Check a different example.
# Issue comes from filtering out things that aren't polygons
# need to include multipolygons for areas that have two separate areas.


