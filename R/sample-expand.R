
library(dplyr)
library(tibble)

test_data <- data.frame(
  bob = c(distributional::dist_uniform(2,3), 
          distributional::dist_normal(3,2), 
          distributional::dist_exponential(3)),
  john = c(distributional::dist_gamma(2,1), 
           distributional::dist_normal(5,1), 
           distributional::dist_exponential(1)),
  ken = c(1,2,3),
  rob = c("A", "B", "C")
)

test_data_sf <- ggdibbler::toy_temp_dist 



sample_expand <- function(data, times){
  
  # Check which variables are distributions
  distcols <- dist_names(data)
  polygoncols <- poly_names(data)
  
  # Return original data if no distribution columns
  if(length(distcols)==0) return(data |> rowid_to_column(var = "distID"))
  
  # Expand sample out into individual data values
  data |>
    mutate(across(all_of(distcols), ~ generate(.x, times = times)),
           across(all_of(distcols) = ) |>
    group_by(across(-all_of(distcols))) |>
    unnest_longer(all_of(distcols)) |>
    tibble::rowid_to_column(var = "distID") |>
    mutate(distID = distID%%times + 1)
}

# gives list of column names that are a distribution
dist_names <- function(data){
  names(data)[sapply(data, is_distribution)]
}

poly_names <- function(data){
  names(data)[sapply(data, sf::is_geometry_column)]
}

sf_expand <- function(data){
  data |>
    group_by(geometry) |>
    reframe(
      geometry = subdivide(geometry, d=c(n,n)), 
      across(everything())
    ) |>
    mutate(fill = as.double(generate(fill, 1))) |>
    st_sf() |>
    st_zm()
}


# internal function for subdividing geometry grid
subdivide <- function(geometry, d){
  n.overlaps <- NULL #to avoid binding error
  # make n*n grid
  nn_grid <- st_make_grid(geometry, n=d)
  # combine grid and original geometry into sf
  comb_data <- c(geometry, nn_grid)
  comb_sf <- st_sf(comb_data)
  # get interactions of grid and orginal geometry
  inter_sf <- st_intersection(comb_sf)
  # new subdivided geometry 
  subdivided <- inter_sf |> 
    filter(n.overlaps >=2) |> #get grid elements that overlap with original shape
    filter(st_geometry_type(comb_data) %in% c("POLYGON", "MULTIPOLYGON")) # get rid of other weird line stuff
  subdivided$comb_data
}
