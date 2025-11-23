library(vdiffr)
library(ggplot2)
library(distributional)
b  <- ggplot(uncertain_mtcars, aes(cyl, mpg)) + geom_point_sample()

test_that("stat_summary_sample tests", {
  
  set.seed(876)
  
  p1 <- b + stat_summary_sample(fun.data = "mean_cl_boot", alpha=0.5,
                                colour = "red")
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + stat_summary_sample(fun = "median", colour = "red", geom = "point")
  expect_doppelganger("Example 2", p2)
  
  p3 <- b + aes(colour = dist_transformed(vs, factor, as.numeric)) + 
    stat_summary_sample(fun = mean, geom="line") +
    labs(colour = "factor(vs)")
  expect_doppelganger("Example 3", p3)
  
}
)

################ PASS #################

# d + stat_summary(fun = "mean", colour = "red", geom = "point")
# b + stat_summary_sample(fun = "mean", colour = "red", geom = "point")
# 
# d + stat_summary(fun = mean, fun.min = min, fun.max = max, colour = "red")
# b + stat_summary_sample(fun = mean, fun.min = min, fun.max = max, 
#                         colour = "red")

############### FAIL #################

# # Orientation follows the discrete axis
# ggplot(mtcars, aes(mpg, factor(cyl))) +
#   geom_point() +
#   stat_summary(fun.data = "mean_cl_boot", colour = "red")
# 
# ggplot(uncertain_mtcars, aes(mpg, dist_transformed(cyl, factor, as.numeric))) +
#   geom_point_sample() +
#   stat_summary_sample(fun.data = "mean_cl_boot", colour = "red")

############## UNTESTED #################
# 
# d <- ggplot(diamonds, aes(cut))
# d + geom_bar()
# d + stat_summary(aes(y = price), fun = "mean", geom = "bar")
# 
# # Orientation of stat_summary_bin is ambiguous and must be specified directly
# ggplot(diamonds, aes(carat, price)) +
#   stat_summary_bin(fun = "mean", geom = "bar", orientation = 'y')
# 
# 
# # Don't use ylim to zoom into a summary plot - this throws the
# # data away
# p <- ggplot(mtcars, aes(cyl, mpg)) +
#   stat_summary(fun = "mean", geom = "point")
# p
# p + ylim(15, 30)
# # Instead use coord_cartesian
# p + coord_cartesian(ylim = c(15, 30))
# 
# # A set of useful summary functions is provided from the Hmisc package:
# stat_sum_df <- function(fun, geom="crossbar", ...) {
#   stat_summary(fun.data = fun, colour = "red", geom = geom, width = 0.2, ...)
# }
# d <- ggplot(mtcars, aes(cyl, mpg)) + geom_point()
# # The crossbar geom needs grouping to be specified when used with
# # a continuous x axis.
# d + stat_sum_df("mean_cl_boot", mapping = aes(group = cyl))
# d + stat_sum_df("mean_sdl", mapping = aes(group = cyl))
# d + stat_sum_df("mean_sdl", fun.args = list(mult = 1), mapping = aes(group = cyl))
# d + stat_sum_df("median_hilow", mapping = aes(group = cyl))
# 
# # An example with highly skewed distributions:
# if (require("ggplot2movies")) {
#   set.seed(596)
#   mov <- movies[sample(nrow(movies), 1000), ]
#   m2 <-
#     ggplot(mov, aes(x = factor(round(rating)), y = votes)) +
#     geom_point()
#   m2 <-
#     m2 +
#     stat_summary(
#       fun.data = "mean_cl_boot",
#       geom = "crossbar",
#       colour = "red", width = 0.3
#     ) +
#     xlab("rating")
#   m2
#   # Notice how the overplotting skews off visual perception of the mean
#   # supplementing the raw data with summary statistics is _very_ important
#   
#   # Next, we'll look at votes on a log scale.
#   
#   # Transforming the scale means the data are transformed
#   # first, after which statistics are computed:
#   m2 + scale_y_log10()
#   # Transforming the coordinate system occurs after the
#   # statistic has been computed. This means we're calculating the summary on the raw data
#   # and stretching the geoms onto the log scale.  Compare the widths of the
#   # standard errors.
#   m2 + coord_transform(y="log10")
# }



