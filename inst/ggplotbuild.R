library(tidyverse)

set.seed(1)

# randomly generate data with a random error
estimate_data <- tibble(xmean = rnorm(50),
                        xse = rep(0.5, 50))|>
  mutate(xdist = distributional::dist_normal(xmean, xse))

expanded_data <- estimate_data |>
  # ggdibbler internal sample_expand
  ggdibbler:::sample_expand(times=1) |>
  select(-c(xmean, xse)) 

# ggplot of density for comparison
#plot <- ggplot(data = expanded_data, aes(x=x)) +
#  geom_density(linewidth = 0.1, colour="indianred1") +
#  coord_cartesian(xlim =c(-3,3), ylim=c(0,0.7)) 


plot <- ggplot(data = estimate_data) + 
  geom_sample_density(aes(x=xdist), times=3) 

# ggbuild code
plot <- ggplot2:::plot_clone(plot)
if (length(plot@layers) == 0) {
  plot <- plot + geom_blank()
}

layers <- plot@layers
data <- rep(list(NULL), length(layers))

scales <- plot@scales

# Allow all layers to make any final adjustments based
# on raw input data and plot info
data <- ggplot2:::by_layer(function(l, d) l$layer_data(plot@data), layers, data, "computing layer data")
data <- ggplot2:::by_layer(function(l, d) l$setup_layer(d, plot), layers, data, "setting up layer")

# Initialise panels, add extra data for margins & missing faceting
# variables, and add on a PANEL variable to data
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
data <- by_layer(function(l, d) l$compute_geom_1(d), layers, data, "setting up geom")

# Apply position adjustments
data <- by_layer(function(l, d) l$compute_position(d, layout), layers, data, "computing position")

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
plot@theme <- plot_theme(plot)

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

# Fill in defaults etc.
data <- by_layer(
  function(l, d) l$compute_geom_2(d, theme = plot@theme),
  layers, data, "setting up geom aesthetics"
)

# Let layer stat have a final say before rendering
data <- by_layer(function(l, d) l$finish_statistics(d), layers, data, "finishing layer stat")

# Let Layout modify data before rendering
data <- layout$finish_data(data)

# Consolidate alt-text
plot@labels$alt <- get_alt_text(plot)

build <- class_ggplot_built(data = data, layout = layout, plot = plot)
class(build) <- union(c("ggplot2::ggplot_built", "ggplot_built"), class(build))
build
}