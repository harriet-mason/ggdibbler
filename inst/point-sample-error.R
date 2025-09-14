# Example with error
library(ggplot2)
devtools::load_all()

test_data <- data.frame(
  bob = c(distributional::dist_uniform(2,3), 
          distributional::dist_normal(3,2), 
          distributional::dist_exponential(3)),
  john = c(distributional::dist_gamma(2,1), 
           distributional::dist_normal(5,1), 
           distributional::dist_exponential(1)),
  ken = c(1,2,3),
  rob = c("A", "B", "C")

####################################################################################
# Broken plot
# make data that doesn't work
)

# position case
p <- ggplot() + 
  stat_sample(data = test_data, ggplot2::aes(x=bob, y=john))
  

# Colour case
basic_data <- toy_temp_dist |>
  dplyr::filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County"))

p2 <- basic_data |>
  ggplot() + 
  geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist)) +
  scale_fill_distiller(palette = "OrRd")

# This returns scale error
# ggplot_build(p)


# Internals of ggplot_build(p) AKA build_ggplot(p)
plot <- p
# idk what the point of this is
plot <- ggplot2:::plot_clone(plot)
# check I guess it checks if you passed empty ggplot()
if (length(plot@layers) == 0) {
  plot <- plot + geom_blank()
}
# set layers, data, and scales
layers <- plot@layers
data <- rep(list(NULL), length(layers))
scales <- plot@scales

# something about final adjustments??
data <- ggplot2:::by_layer(function(l, d) l$layer_data(plot@data), layers, data, "computing layer data")
data <- ggplot2:::by_layer(function(l, d) l$setup_layer(d, plot), layers, data, "setting up layer")

# initialise panels
layout <- ggplot2:::create_layout(plot@facet, plot@coordinates, plot@layout)
data <- layout$setup(data, plot@data, plot@plot_env)

# Compute aesthetics to produce data with generalised variable names
data <- ggplot2:::by_layer(function(l, d) l$compute_aesthetics(d, plot), layers, data, "computing aesthetics")
plot@labels <- ggplot2:::setup_plot_labels(plot, layers, data)
data <- .ignore_data(data)

# Transform all scales
data <- lapply(data, scales$transform_df)

# Map and train positions so that statistics have access to ranges
# and all positions are numeric
scale_x <- function() scales$get_scales("x")
scale_y <- function() scales$get_scales("y")

# This throws error
layout$train_position(data, scale_x(), scale_y())

####################################################################################

