# load library
library(vdiffr)
library(ggplot2)

# test_that("geom_tile_sample tests", {
#   
#   set.seed(***)
#   
#   p* <- ggplot()
#   expect_doppelganger("example1", p1)
#   
# }
# )
# 
# test_that("geom_rect_sample tests", {
#   
#   set.seed(***)
#   
#   p* <- ggplot()
#   expect_doppelganger("example1", p1)
#   
# }
# )

# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################

library(distributional)
library(dplyr)
# The most common use for rectangles is to draw a surface. You always want
# to use geom_raster here because it's so much faster, and produces
# smaller output when saving to PDF
ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density))

# Interpolation smooths the surface & is most helpful when rendering images.
ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density), interpolate = TRUE)

# If you want to draw arbitrary rectangles, use geom_tile() or geom_rect()
df <- data.frame(
  x = rep(c(2, 5, 7, 9, 12), 2),
  y = rep(c(1, 2), each = 5),
  z = factor(rep(1:5, each = 2)),
  w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
)

uncertain_df <- df |>
  mutate(
    x = dist_sample(list(sample(seq(from=x, to = x+5), replace = TRUE))),
    y = dist_sample(list(sample(seq(from=y, to = y+5), replace = TRUE))),
    z = dist_sample(list(sample(seq(from=z, to = z+5), replace = TRUE))),
    w = dist_sample(list(sample(seq(from=w, to = w+5), replace = TRUE)))
    )
dist_sample(list(sample(seq(from=df$x[1], to = df$x[1]+5), replace = TRUE)))
year_dist = dist_sample(list(sample(seq(from=year-2, to = year+2), replace = TRUE)))

ggplot(df, aes(x, y)) +
  geom_tile(aes(fill = z), colour = "grey50")
ggplot(df, aes(x, y)) +
  geom_tile_sample(aes(fill = dist_binomial(as.numeric(z), 0.5)), colour = "grey50")
ggplot(df, aes(x, y, width = w)) +
  geom_tile(aes(fill = z), colour = "grey50")
ggplot(df, aes(xmin = x - w / 2, xmax = x + w / 2, ymin = y, ymax = y + 1)) +
  geom_rect(aes(fill = z), colour = "grey50")


# Justification controls where the cells are anchored
df <- expand.grid(x = 0:5, y = 0:5)
set.seed(1)
df$z <- runif(nrow(df))
# default is compatible with geom_tile()
ggplot(df, aes(x, y, fill = z)) +
  geom_raster()
# zero padding
ggplot(df, aes(x, y, fill = z)) +
  geom_raster(hjust = 0, vjust = 0)

# Inspired by the image-density plots of Ken Knoblauch
cars <- ggplot(mtcars, aes(mpg, factor(cyl)))
cars + geom_point()
cars + stat_bin_2d(aes(fill = after_stat(count)), binwidth = c(3,1))
cars + stat_bin_2d(aes(fill = after_stat(density)), binwidth = c(3,1))

cars +
  stat_density(
    aes(fill = after_stat(density)),
    geom = "raster",
    position = "identity"
  )
cars +
  stat_density(
    aes(fill = after_stat(count)),
    geom = "raster",
    position = "identity"
  )
