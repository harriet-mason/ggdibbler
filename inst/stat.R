# working out inputs and outputs
library(tidyverse)
devtools::load_all()
library(distributional)

# data with matching names for checking compute_group functions
named <- toymap |>
  rename(x = county_name, y = temp_dist) |>
  select(x, y)

# three data sets
a <- toymap |> select(county_name, temp)
b <- toymap |> select(county_name, temp_dist)
c <- b |>
  mutate(temp_mean = distributional:::mean.distribution(temp_dist)) %>%
  select(county_name, temp_mean)

###########################################################################

# Location based StatMean
StatMean <- ggplot2::ggproto("StatMean", ggplot2::Stat, 
                       compute_group = function(data, scales) {
                         data$y <- distributional:::mean.distribution(data$y)
                         data
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


# test map
ggplot() +
  # Cannot plot dist and normal variables together, bit of a problem
  # geom_point(data=a, aes(x=county_name, y=temp), size=2, colour="red") +
  stat_mean(data = b, aes(x=county_name, y=temp_dist), size=0.5)

###########################################################################

# Location based StatSample
StatSample <- ggplot2::ggproto("StatMeanVar", ggplot2::Stat,
                               compute_group = function(data, scales, n) {
                                 data$y <- distributional::generate(data$y, n)
                                 data
                               },
                               required_aes = c("y")
)

StatSample$compute_group(named, n=10)


###########################################################################

               
                                            
# Fill based StatMeanVar (cant check without propper ggplot)
StatMeanVar <- ggplot2::ggproto("StatMeanVar", ggplot2::Stat, 
                              compute_group = function(data, scales) {
                                data$mfill <- distributional:::mean.distribution(data$fill)
                                data$vfill <- distributional:::variance.distribution(data$fill)
                                data
                              },
                              required_aes = c("fill")
)
# tested compute_group function and it works. Cant check the rest until fill is done

###########################################################################


StatPDF <- ggproto()

StatProb <- ggproto()


# try and go between condensed and long data frame
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
  