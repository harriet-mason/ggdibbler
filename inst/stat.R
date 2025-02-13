# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

toydata <- toymap |>
  dplyr::filter(county_name == "Story County" | 
                  county_name == "Boone County" | 
                  county_name == "Johnson County")

# data with matching names for checking compute_group functions
named <- toydata |>
  dplyr::rename(x = county_name, y = temp_dist) |>
  dplyr::select(x, y)

# three data sets
a <- toydata |> dplyr::select(county_name, temp)
b <- toydata |> dplyr::select(county_name, temp_dist)
c <- b |>
  dplyr::mutate(temp_mean = distributional:::mean.distribution(temp_dist)) |>
  dplyr::select(county_name, temp_mean)

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
  ggplot2::layer(
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
ggplot2::ggplot() +
  stat_mean(data = b, 
            ggplot2::aes(x=county_name, y=temp_dist), 
            size=0.5)

###########################################################################
# Location based StatSample
StatSample <- ggplot2::ggproto("StatSample", ggplot2::Stat,
                               compute_group = function(data, n=10, scales) {
                                 data |>
                                   dplyr::mutate(y = distributional::generate(y, n)) |>
                                   tidyr::unnest(y)
                                   
                               },
                               required_aes = c("y")
)

stat_sample <- function(mapping = NULL, data = NULL, 
                      geom = "point", position = "identity", 
                      na.rm = FALSE, show.legend = NA, 
                      inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatSample, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
}

# test plot
ggplot2::ggplot() +
  stat_sample(data = b, 
            ggplot2::aes(x=county_name, y=temp_dist), 
            size=0.5)

###########################################################################

StatProb <- ggplot2::ggproto("StatProb", ggplot2::Stat,
                    compute_group = function(data, p, scales) {
                      
                      data |>
                        dplyr::mutate(y = distributional:::quantile.distribution(y, p)) |>
                        tidyr::unnest(y)
                      
                    },
                    required_aes = c("y")
)
p <- c(0.2, 0.4, 0.6, 0.8)
StatProb$compute_group(named, p)

stat_sample <- function(mapping = NULL, data = NULL, 
                      geom = "point", position = "identity", 
                      na.rm = FALSE, show.legend = NA, 
                      inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatSample, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
}

# test plot
ggplot2::ggplot() +
  stat_sample(data = b, 
            ggplot2::aes(x=county_name, y=temp_dist), 
            size=0.5)
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
m <- toydata |>
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
  