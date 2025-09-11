###########################################################################
# General Set up
devtools::load_all()

toydata <- toy_temp_dist |>
  dplyr::filter(county_name %in% c("Story County", "Boone County", "Johnson County"))

# Named dataset for checking compute group
named <- toydata |>
  dplyr::rename(x = county_name, y = temp_dist) |>
  dplyr::select(x, y) |>
  sf::st_drop_geometry()

# test data set for checking actual data
test <- toydata |> dplyr::select(county_name, temp_dist)

###########################################################################
# StatSampleConditional?




###########################################################################
# StatMean

StatMean <- ggplot2::ggproto("StatMean", ggplot2::Stat, 
                             compute_group = function(data, scales) {
                               data$y <- distributional:::mean.distribution(data$y)
                               data
                             },
                             required_aes = c("y")
)

# data with matching names for checking compute_group functions

StatMean$compute_group(named)

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
  stat_mean(data = test, 
            ggplot2::aes(x=county_name, y=temp_dist), 
            size=0.5)

###########################################################################
# Stat Prob

StatProb <- ggplot2::ggproto("StatProb", ggplot2::Stat,
                    compute_group = function(data, scales, p = NULL) {
                      if (is.null(p)) {p = c(0.2, 0.4, 0.6, 0.8)}
                      data |>
                        dplyr::mutate(y = distributional:::quantile.distribution(y, p)) |>
                        tidyr::unnest(y)
                      
                    },
                    required_aes = c("y")
)

stat_prob <- function(mapping = NULL, data = NULL, 
                      geom = "point", position = "identity", 
                      na.rm = FALSE, show.legend = NA, 
                      inherit.aes = TRUE, p = NULL, ...) {
  ggplot2::layer(
    stat = StatProb, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm,
                  p = p, ...)
  )
}

p <- c(0.1, 0.3, 0.5, 0.7, 0.9)

# test plot
ggplot2::ggplot() +
  stat_prob(data = b, 
            ggplot2::aes(x=county_name, y=temp_dist), p=p,
            size=0.5)

###########################################################################

# idk if getting the pdf function would have any use
StatPDF <- ggproto() 


  