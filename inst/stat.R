# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

toydata <- toymap |>
  dplyr::filter(county_name %in% c("Story County", "Boone County", "Johnson County")

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
                    compute_group = function(data, p=NULL, scales) {
                      if (is.null(p)) {p = c(0.2, 0.4, 0.6, 0.8)}
                      data |>
                        dplyr::mutate(y = distributional:::quantile.distribution(y, p)) |>
                        tidyr::unnest(y)
                      
                    },
                    required_aes = c("y")
)
StatProb$compute_group(named)
p <- c(0.1, 0.3, 0.5, 0.7, 0.9)
StatProb$compute_group(named, p)

stat_prob <- function(mapping = NULL, data = NULL, 
                      geom = "point", position = "identity", 
                      na.rm = FALSE, show.legend = NA, 
                      inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatProb, 
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
  stat_prob(data = b, 
            ggplot2::aes(x=county_name, y=temp_dist), 
            size=0.5)

###########################################################################

# idk if getting the pdf function would have any use
StatPDF <- ggproto() 


  