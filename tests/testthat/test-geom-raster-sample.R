library(vdiffr)

test_that("geom_**_sample tests", {
  
  set.seed(***)
  
  p* <- ggplot()
  expect_doppelganger("example1", p1)
  
}
)

# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################

# The most common use for rectangles is to draw a surface. You always want
# to use geom_raster here because it's so much faster, and produces
# smaller output when saving to PDF
ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density))

# Interpolation smooths the surface & is most helpful when rendering images.
ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density), interpolate = TRUE)


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