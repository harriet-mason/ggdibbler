
library(vdiffr)
library(ggplot2)
library(dplyr)
library(distributional)

# have to make factor variable, probably easier ways to do it
uncertain_mtcars2 <- uncertain_mtcars |>
  rowwise() |> #must have this or the distributions get mixed up
  mutate(cyl_factor = dist_sample(list(factor(unlist(generate(cyl,100))))))

# plot set up
q <- ggplot(uncertain_mtcars2, aes(cyl_factor, mpg))

test_that("geom_violin_sample tests", {
  
  set.seed(545)
  
  p1 <- q + geom_violin_sample(alpha=0.1)
  expect_doppelganger("Example 1", p1)
  
  p2 <-ggplot(uncertain_mtcars2, aes(mpg, cyl_factor)) +
    geom_violin_sample(alpha=0.1)
  expect_doppelganger("Example 2", p2)
  
  p3 <- q + geom_violin_sample(alpha=0.1) + 
    geom_jitter_sample(height = 0, width = 0.1, size=0.1)
  expect_doppelganger("Example 3", p3)
  
  p4 <- q + geom_violin_sample(scale = "count")
  expect_doppelganger("Example 4", p4)
  
  p5 <- q + geom_violin_sample(scale = "width", alpha=0.1)
  expect_doppelganger("Example 5", p5)
  
  p6 <- q + geom_violin_sample(trim = FALSE, alpha=0.1)
  expect_doppelganger("Example 6", p6)
  
  p7 <- q + geom_violin_sample(adjust = .5, alpha=0.1)
  expect_doppelganger("Example 7", p7)
  
  p8 <- ggplot(uncertain_mtcars2, aes(cyl_factor, mpg)) + 
    geom_violin_sample(aes(fill = after_stat(x))) 
  expect_doppelganger("Example 8", p8)
  
  p9 <- q + geom_violin_sample(aes(fill = factor(after_stat(x))))
  expect_doppelganger("Example 9", p9)
  
  p10 <- q + geom_violin_sample(fill = "grey80", colour = "#3366FF", alpha=0.1)
  expect_doppelganger("Example 10", p10)
}
)

################ PASS #################
############### FAIL #################
# Need nest postion -> dodge_identity
# ggplot
# p + geom_violin(aes(fill = factor(vs)))
# # ggdibbler
# q + geom_violin_sample(aes(fill = vs_factor), alpha=0.2)
# # ggplot
# p + geom_violin(aes(fill = am_factor))
# p + geom_violin(aes(fill = am_factor))

# # Show quartiles
# # ggplot
# p + geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
# # ggdibbler (doesnt work)
# q + geom_violin_sample(quantiles = c(0.25, 0.5, 0.75), alpha=0.2)

############## UNTESTED #################

# # Scales vs. coordinate transforms -------
# if (require("ggplot2movies")) {
#   # Scale transformations occur before the density statistics are computed.
#   # Coordinate transformations occur afterwards.  Observe the effect on the
#   # number of outliers.
#   m <- ggplot(movies, aes(y = votes, x = rating, group = cut_width(rating, 0.5)))
#   m + geom_violin()
#   m +
#     geom_violin() +
#     scale_y_log10()
#   m +
#     geom_violin() +
#     coord_transform(y = "log10")
#   m +
#     geom_violin() +
#     scale_y_log10() + coord_transform(y = "log10")
#   
#   # Violin plots with continuous x:
#   # Use the group aesthetic to group observations in violins
#   ggplot(movies, aes(year, budget)) +
#     geom_violin()
#   ggplot(movies, aes(year, budget)) +
#     geom_violin(aes(group = cut_width(year, 10)), scale = "width")
# }
