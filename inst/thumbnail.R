set.seed(10)
library(ggdibbler)
library(patchwork)
library(ggthemes)
library(colorspace)
library(tidygraph)
library(ggraph)
library(tidyverse)
library(ggrepel)
library(ozmaps)
library(sf)
library(distributional)

# any data edits
# GRAPH DF
uncertain_edges <- tibble::tibble(from = sample(5, 20, TRUE),
                                  to = sample(5, 20, TRUE),
                                  weight = runif(20)) |>
  dplyr::group_by(from, to) |>
  dplyr::mutate(to = distributional::dist_sample(list(sample(seq(from=max(1,to-1), 
                                                                 to = min(to+1, 5)), 
                                                             replace = TRUE)))) |>
  ungroup()
graph_sample <- uncertain_edges |>
  sample_expand(times=50) |>
  as_tbl_graph()
jitter = position_jitter(width=0.03, height=0.03)

# TILE DF
tile_df <- data.frame(
  x = rep(c(2, 5, 7, 9, 12), 2),
  y = rep(c(1, 2), each = 5),
  z = factor(rep(1:5, each = 2)),
  w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
)
uncertain_tile_df <- tile_df
uncertain_tile_df$z <- dist_transformed((1 + dist_binomial(rep(1:5,
  each = 2), 0.5)), factor, as.numeric)

# TEXT DATA
textdata <- expand_grid(x = c(1,2,3), y= c(1,2,3)) |>
  mutate(
    z0 = sample(c(TRUE, FALSE), 9, replace=TRUE),
    z = dist_bernoulli(0.2 + 0.6*z0)
  )

# SPOKE DATA
df <- expand.grid(x = 1:10, y=1:10)
df$angle <- runif(100, 0, 2*pi)
df$speed <- runif(100, 0, sqrt(0.1 * df$x))

# uncertain data
spoke_df <- expand.grid(x = 1:5, y=1:5) |>
  group_by(x,y) |>
  mutate(angle = dist_normal(runif(1, 0, 2*pi), runif(1,0, 0.5)),
         speed = dist_normal(runif(1, 0, sqrt(0.1 *x)), runif(1,0, 0.1))) |>
  ungroup()

# geom_sf data
Aust_map <- ozmap_data(data = "states", quiet = TRUE) |>
  group_by(NAME) |>
  mutate(value = dist_normal(mu = rnorm(1, 30, 10), rexp(1, 0.3))) |>
  ungroup()

palname <- "SunsetDark"
# DATA PLOTS
pal <- sequential_hcl(7, palette = palname)
# geom_bar
pbar <- ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv),, times=50)+
  theme_few() +
  theme(aspect.ratio=1, legend.position = "none") +
  scale_fill_discrete_sequential(palette = palname) 

# geom_contour
pcont <- ggplot(uncertain_faithful, aes(waiting, eruptions))+
  theme_few() +
  theme(aspect.ratio=1, legend.position = "none") +
  geom_density_2d_sample(aes(colour = after_stat(level))) +
  scale_colour_continuous_sequential(palette = palname) 


# geom_tile/raster
ptile <- ggplot(uncertain_tile_df, aes(x, y, fill = z)) +
  geom_raster_sample(times = 30) +
  theme_few() +
  theme(aspect.ratio=1, legend.position = "none") +
  scale_fill_discrete(palette = pal) 

# geom_abline
pline <- ggplot(mtcars, aes(wt, mpg)) + 
  geom_abline_sample(intercept = dist_normal(37, 1.8),
                     slope = dist_normal(-5, 0.56), 
                     times=30, alpha=0.25,
                     colour = pal[1]) +
  geom_point(colour = "black") + 
  theme_few() +
  theme(aspect.ratio=1, legend.position = "none") 

# geom_text
ptext <- ggplot(textdata, aes(x=x, y=y, colour=z)) +
  geom_text(aes(label = after_stat(colour)), fontface = "bold",
                   size=5, alpha=1.5/30, times=30, stat="identity_sample") +
  theme_few() +
  theme(aspect.ratio = 1, legend.position = "none")  +
  scale_colour_discrete_sequential(palette = palname) +
  scale_x_continuous_distribution(limits = c(0.5,3.5)) +
  scale_y_continuous_distribution(limits = c(0.5,3.5))

# ggraph
pgraph <- ggraph(graph_sample, weights = weight) + 
  geom_edge_link(aes(group=drawID), position=jitter, alpha=0.01, 
                 linewidth=1, colour = pal[3]) + 
  theme_few() +
  theme(aspect.ratio = 1) +
  geom_node_point(size=5, colour = pal[3], alpha=0.5)


# geom_spoke
pspoke <- ggplot(spoke_df, aes(x, y, colour = angle)) + 
  theme_few() +
  theme(aspect.ratio = 1, legend.position = "none") +
  geom_spoke_sample(aes(angle = after_stat(colour), radius = 1.5*speed),
                    times = 50, alpha=0.1, 
                    linewidth = 1, lineend = "round") +
  scale_colour_continuous(palette = pal) +
  geom_point_sample(size=2, colour = "black")

# geom_historgram
phist <- ggplot(smaller_uncertain_diamonds, aes(carat, fill = cut)) +
  geom_histogram_sample(position="stack_identity", alpha=0.05, times=30) +
  theme_few() +
  theme(aspect.ratio = 1, legend.position="none") +
  scale_fill_discrete(palette = pal) 

# geom_sf
psf <- ggplot(data = Aust_map, aes(geometry = geometry, fill = value)) + 
  geom_sf_sample(times = 300, linewidth = 0) +
  theme_few() +
  theme(aspect.ratio = 1, legend.position="none") +
  scale_fill_continuous_sequential(palette = palname) +
  geom_sf(fill = NA, linewidth = 0.5, colour = "black") +
  scale_x_continuous_distribution(limits = c(111,155))

# geom_count
pcount <- ggplot(uncertain_mpg, aes(cty, hwy)) +
  geom_count_sample(alpha=0.05, colour = pal[5], times=30) +
  theme_few() +
  theme(aspect.ratio = 1, legend.position="none") +
  scale_colour_continuous_sequential(palette = palname) 



p <- pline +  pspoke + phist + psf  + pbar + pcount
ggsave('inst/logo.png', plot = p, width = 3500, height = 3000, units = 'px')



