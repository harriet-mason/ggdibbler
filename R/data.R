# Generate Basic Data
library(distributional)
library(tidyverse)

temps
c(dist_normal(0,1), dist_normal(4,7), dist_normal(2,8))
tibble(
  dist = c(dist_normal(0,1), dist_normal(4,7), dist_normal(2,8))
) |> 
  mutate(
    sample = generate(dist, 10),
    params = parameters(dist)
  )


my_map_data <- get_urbn_map("counties", sf = TRUE) |>
  filter(state_name=="Iowa")
save(my_map_data, file="data/iowa_map.rda")

centroids <- as_tibble(gCentroid(as(my_map_data$geometry, "Spatial"), byid = TRUE))
my_map_data$cent_long <- centroids$x
my_map_data$cent_lat <- centroids$y
save(my_map_data, file="data/my_map_data.rda")



# seed for sampling
set.seed(1997)

# data dimension for sampling
n <- dim(my_map_data)[1]

# Make palettes
longpal <- rev(sequential_hcl(13, palette = "YlOrRd"))
basecols <- longpal[3:10]
breaks <- 21:29 
breakslong <- 18:32 
names(basecols) <- seq(8)
names(longpal) <- -1:11

my_map_data <- my_map_data |>
  mutate(temp = 29 - 2*abs(scale(cent_lat) - sin(2*(scale(cent_long)))[,1]), # trend
         highvar = runif(n, min=2, max=4), # high variance
         lowvar = runif(n, min=0, max=2), # low variance
         count_id = row_number()) |>
  pivot_longer(cols=highvar:lowvar, names_to = "variance_class", values_to = "variance") |>
  # add bivariate classes to data
  mutate(bitemp = cut(temp, breaks=breaks, labels=seq(8)),
         bivar = cut(variance, breaks=0:4, labels=seq(4)),
         biclass = paste(bitemp, bivar, sep="-"))|>
  mutate(highlight = ifelse(count_id <= 5, TRUE, FALSE))
