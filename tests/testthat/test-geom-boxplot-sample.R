library(vdiffr)
library(ggplot2)

# single random variable data prep
uncertain_mpg_new <- uncertain_mpg
uncertain_mpg_new$class <- mpg$class

suppressMessages({
test_that("geom_boxplot_sample tests", {

  set.seed(324)
  
  q <- ggplot(uncertain_mpg, aes(class, hwy)) 
  
  p1 <- q + geom_boxplot_sample(alpha=0.1)
  expect_doppelganger("Example 1", p1)
  
  r <- ggplot(uncertain_mpg_new, aes(class, hwy)) 
  p2 <- r  + geom_boxplot_sample(alpha=0.1)
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_mpg, aes(hwy, class)) +
    geom_boxplot_sample(alpha=0.1) 
  expect_doppelganger("Example 3", p3)
  
  p4 <- q + geom_boxplot_sample(alpha=0.1, notch = TRUE)
  expect_doppelganger("Example 4", p4)
  
  p5 <- q + geom_boxplot_sample(alpha=0.1, varwidth = TRUE)
  expect_doppelganger("Example 5", p5)
  
  p6 <- q + geom_boxplot_sample(alpha=0.1, fill = "white", colour = "#3366FF")
  expect_doppelganger("Example 6", p6)
  
  p7 <- q + geom_boxplot_sample(alpha=0.1, outlier.colour = "red", outlier.shape = 1)
  expect_doppelganger("Example 7", p7)
  
  p8 <- q + geom_boxplot_sample(alpha=0.1, outlier.shape = NA) +
    geom_jitter_sample(size= 0.1, width = 0.2)
  expect_doppelganger("Example 8", p8)

}
)
})


# ################ PASS #################
# ############### FAIL #################


# # VARWIDTH FORCED DODGE (in examples but will need to be checked again)
# # COLOUR DODGE
# # CANNOT BE IMPLEMENTED UNTIL TIERED POSITION IMPLEMENTED
# # Boxplots are automatically dodged when any aesthetic is a factor
# p + geom_boxplot(aes(colour = drv))
# # Boxplots are automatically dodged when any aesthetic is a factor
# q + geom_boxplot_sample(aes(colour = drv), alpha=0.1)

# ############## UNTESTED #################


# # diamonds is too big
# # You can also use boxplots with continuous x, as long as you supply
# # a grouping variable. cut_width is particularly useful
# ggplot(diamonds, aes(carat, price)) +
#   geom_boxplot()
# 
# ggplot(uncertain_diamonds, aes(carat, price)) +
#   geom_boxplot_sample(times=2)
# 
# 
# ggplot(diamonds, aes(carat, price)) +
#   geom_boxplot(aes(group = cut_width(carat, 0.25)))
# # Adjust the transparency of outliers using outlier.alpha
# ggplot(diamonds, aes(carat, price)) +
#   geom_boxplot(aes(group = cut_width(carat, 0.25)), outlier.alpha = 0.1)

# # It's possible to draw a boxplot with your own computations if you
# # use stat = "identity":
# set.seed(1)
# y <- rnorm(100)
# df <- data.frame(
#   x = 1,
#   y0 = min(y),
#   y25 = quantile(y, 0.25),
#   y50 = median(y),
#   y75 = quantile(y, 0.75),
#   y100 = max(y)
# )
# ggplot(df, aes(x)) +
#   geom_boxplot(
#     aes(ymin = y0, lower = y25, middle = y50, upper = y75, ymax = y100),
#     stat = "identity"
#   )