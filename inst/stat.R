# working out inputs and outputs
library(tidyverse)
library(vctrs)
devtools::load_all()
library(distributional)

# ggproto object 
#make mean/var once working
StatMean <- ggplot2::ggproto("StatMean", Stat, # stat not found if ggplot2 isn't loaded
                       compute_group = function(data, scales) {
                         mean(data$y)
                       },
                       required_aes = c("y")
)

# Layer function
stat_mean <- function(mapping = NULL, data = NULL, 
                                      geom = "point", position = "identity", 
                                      na.rm = FALSE, show.legend = NA, 
                                      inherit.aes = TRUE, ...) {
  layer(
    stat = StatMean, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
}

# test stat
ggplot(toymap, aes(x = county_name)) + 
  geom_point(aes(y=temp), size=2, colour="blue") + 
  stat_mean(aes(y=temp_dist))

######################## TRY WITH COLOUR INSTEAD ####################
# ggproto object 
#make mean/var once working
StatMean <- ggplot2::ggproto("StatMean", Stat, # stat not found if ggplot2 isn't loaded
                             compute_group = function(data, scales) {
                               mean(data$colour)
                               print(mean(data$colour))
                             },
                             required_aes = c("colour")
)

# Layer function
stat_mean <- function(mapping = NULL, data = NULL, 
                      geom = "point", position = "identity", 
                      na.rm = FALSE, show.legend = NA, 
                      inherit.aes = TRUE, ...) {
  layer(
    stat = StatMean, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
}

# test stat
ggplot(toymap, aes(x = county_name, y=temp)) + 
  geom_point(size=2, colour="black") + 
  stat_mean(aes(colour=temp_dist))

###########################################################################

StatSample <- ggproto("StatSample", Stat,
                      compute_group = function(data, scales, n) {
                        data[distributional::sample(data$x, n), , drop = FALSE]
                      },
                      required_aes = c("x")
)


StatPDF <- ggproto()

StatProb <- ggproto()

# Basic DF in DF out approach
sample_df <- function(df){

}
n=10
m <- toymap |>
  select(c(county_name, temp_dist, geometry)) |>
  mutate(count=n) |>
  uncount(count) |>
  rowid_to_column("ID") |>
  group_by(ID, county_name, temp_dist, geometry) |>
  summarise(temp_sample = distributional::generate(temp_dist, 1))
  #separate_longer_delim(temp_sample, delim = ",")
  # I mean it works

# have to use different versions of these functions for sf or tibble
# runs fine if i have tidyerse loaded, but cant call each package indirectly
  