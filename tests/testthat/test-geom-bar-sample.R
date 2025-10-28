library(vdiffr)

test_that("geom_bar_sample tests", {
  # no random variables used - just return normal points
  set.seed(342830498)
  p0 <- ggplot(mpg, aes(class)) + geom_bar_sample()
  expect_doppelganger("deterministic", p0)
  
  p1 <- ggplot(uncertain_mpg, aes(class)) + geom_bar_sample()
    expect_doppelganger("example1", p1)

  # random variables x and y
  p2 <- ggplot(uncertain_mpg, aes(class)) + geom_bar_sample(aes(weight = displ))
    expect_doppelganger("example2", p2)
  
  p3 <- ggplot(uncertain_mpg) + geom_bar_sample(aes(y = class))
  expect_doppelganger("example3", p3)
}
)

####################### FAIL #################
####################### UNTESTED #################

# # Bar charts are automatically stacked when multiple bars are placed
# # at the same location. The order of the fill is designed to match
# # the legend
# g + geom_bar(aes(fill = drv))
# q + geom_bar_sample(aes(fill = drv))
# 
# # If you need to flip the order (because you've flipped the orientation)
# # call position_stack() explicitly:
# ggplot(mpg, aes(y = class)) +
#   geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE)) +
#   theme(legend.position = "top")
# 
# # To show (e.g.) means, you need geom_col()
# df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
# ggplot(df, aes(trt, outcome)) +
#   geom_col()
# # But geom_point() displays exactly the same information and doesn't
# # require the y-axis to touch zero.
# ggplot(df, aes(trt, outcome)) +
#   geom_point()
# 
# # You can also use geom_bar() with continuous data, in which case
# # it will show counts at unique locations
# df <- data.frame(x = rep(c(2.9, 3.1, 4.5), c(5, 10, 4)))
# ggplot(df, aes(x)) + geom_bar()
# # cf. a histogram of the same data
# ggplot(df, aes(x)) + geom_histogram(binwidth = 0.5)
# 
# # Use `just` to control how columns are aligned with axis breaks:
# df <- data.frame(x = as.Date(c("2020-01-01", "2020-02-01")), y = 1:2)
# # Columns centered on the first day of the month
# ggplot(df, aes(x, y)) + geom_col(just = 0.5)
# # Columns begin on the first day of the month
# ggplot(df, aes(x, y)) + geom_col(just = 1)