# Packages for toy data set
library(distributional)
library(tidyverse)
# devtools::install_github("UrbanInstitute/urbnmapr")
library(urbnmapr)
library(rgeos)

# Generate Data
my_map_data <- get_urbn_map("counties", sf = TRUE) |>
  filter(state_name=="Iowa") 

# Re-save so I dont have to keep calling it
toymap <- my_map_data

# this section uses rgeos to make sine wave pattern
centroids <- as_tibble(gCentroid(as(toymap$geometry, "Spatial"), byid = TRUE))
toymap$cent_long <- centroids$x
toymap$cent_lat <- centroids$y

#make trend and variance
toymap <- toymap |>
  mutate(temp = as.double(round(29 - 2*abs(scale(cent_lat) - sin(2*(scale(cent_long)))), digits=1)), # trend
         var = runif(99, min=0, max=3), # high variance
         count_id = row_number()) 

# make distribution tibble
toymap <- toymap |> 
  mutate(temp_dist = dist_normal(temp, var),
         temp_sample = generate(temp_dist, 10)) |> 
  select(county_name, geometry, temp_dist, temp_sample)

# use toymap data in package.
usethis::use_data(toymap)


## MAKE INTO DIBBLE OBJECT
#install.packages("S7")
library(S7)

# class is dibble, method is changed ggplot functions, generic.class
# check class with typeof() and class()
# ftype(ggplot) = generic
# ftype(ggplot.sf) = method

# S3 Practice
# method 1
x <- structure(list(), class = "my_class")

# method 2
x <- list()
class(x) <- "my_class"

# so can just do
class(toymap) <- "dibble"

inherits(m, "tbl") #=true because tible in list
inherits(m, "data.frame") #=true becase data.frame in list
inherits(m, "dibble") #=false becase dibble not in list
