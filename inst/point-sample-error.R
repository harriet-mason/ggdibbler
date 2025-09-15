# Example with error
library(ggplot2)
devtools::load_all()

data <- data.frame(
  bob = c(distributional::dist_uniform(2,3), 
          distributional::dist_normal(3,2), 
          distributional::dist_exponential(3)),
  john = c(distributional::dist_gamma(2,1), 
           distributional::dist_normal(5,1), 
           distributional::dist_exponential(1)),
  ken = c(1,2,3),
  rob = c("A", "B", "C"))

####################################################################################
# Broken plot
# make data that doesn't work
plot <- p

# position case
library(ggplot2)
plot <- ggplot2::ggplot() + 
  stat_sample(data = test_data, ggplot2::aes(x=bob, y=john, colour = as.factor(bob))) 

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


layout$train_position(data, scale_x(), scale_y())
data <- layout$map_position(data)
data <- .expose_data(data)

# Apply and map statistics
data <- ggplot2:::by_layer(function(l, d) l$compute_statistic(d, layout), layers, data, "computing stat")
data <- ggplot2:::by_layer(function(l, d) l$map_statistic(d, plot), layers, data, "mapping stat to aesthetics")

# Make sure missing (but required) aesthetics are added
plot@scales$add_missing(c("x", "y"), plot@plot_env)

# Reparameterise geoms from (e.g.) y and width to ymin and ymax
data <- ggplot2:::by_layer(function(l, d) l$compute_geom_1(d), layers, data, "setting up geom")

# Apply position adjustments
data <- ggplot2:::by_layer(function(l, d) l$compute_position(d, layout), layers, data, "computing position")

# Reset position scales, then re-train and map.  This ensures that facets
# have control over the range of a plot: is it generated from what is
# displayed, or does it include the range of underlying data
data <- .ignore_data(data)
layout$reset_scales()
layout$train_position(data, scale_x(), scale_y())
layout$setup_panel_params()
data <- layout$map_position(data)

# Hand off position guides to layout
layout$setup_panel_guides(plot@guides, plot@layers)

# Complete the plot's theme
plot@theme <- ggplot2:::plot_theme(plot)

# Train and map non-position scales and guides
npscales <- scales$non_position_scales()
if (npscales$n() > 0) {
  npscales$set_palettes(plot@theme)
  lapply(data, npscales$train_df)
  plot@guides <- plot@guides$build(npscales, plot@layers, plot@labels, data, plot@theme)
  data <- lapply(data, npscales$map_df)
} else {
  # Only keep custom guides if there are no non-position scales
  plot@guides <- plot@guides$get_custom()
}
data <- .expose_data(data)

data <- ggplot2:::by_layer(
  function(l, d) l$compute_geom_2(d, theme = plot@theme),
  layers, data, "setting up geom aesthetics"
)
data <- by_layer(function(l, d) l$finish_statistics(d), layers, data, "finishing layer stat")
####################################################################################

dist <- dist_normal(mu = 1:5, sigma = 3)
t <- transform_dist()
t$transform(dist)
t$inverse(t$transform(dist))

####################################################################################
# Check scale applied to other ggplots
# make data that doesn't work

# Distribution case
plot <- ggplot() + 
  stat_sample(data = test_data, ggplot2::aes(x=bob, y=john))
scales <- plot@scales
data <- lapply(data, scales$transform_df)
scales$transform_df

####################################################################################
# continusous data case
plot <- ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point(stat = "summary") +
  scale_x_log10()


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



