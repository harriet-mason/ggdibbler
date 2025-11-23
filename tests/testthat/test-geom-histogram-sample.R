# load libraries
library(vdiffr)
library(ggplot2)

suppressMessages({
test_that("geom_histogram_sample tests", {

  set.seed(34)
  p1 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_histogram_sample(alpha=0.1) # alpha
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_histogram_sample(position="dodge") # dodge
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_histogram_sample(binwidth = 0.01, alpha=0.2)
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_histogram_sample(bins = 200, alpha=0.2)
  expect_doppelganger("Example 4", p4)
  
  p5 <- ggplot(smaller_uncertain_diamonds, aes(y = carat)) +
    geom_histogram_sample(alpha=0.2)
  expect_doppelganger("Example 5", p5)
  
  p6 <- ggplot(uncertain_economics_long, aes(value)) +
    facet_wrap(~variable, scales = 'free_x') +
    geom_histogram_sample(binwidth = \(x) 2 * IQR(x) / (length(x)^(1/3)), 
                          alpha=0.2)
  expect_doppelganger("Example 6", p6)

}
)
})

############### FAIL #################

# ISSUE WITH BINNING POSITION SCALE
# # For histograms with tick marks between each bin, use `geom_bar()` with
# # `scale_x_binned()`.
# ggplot(smaller_diamonds, aes(carat)) +
#   geom_bar() +
#   scale_x_binned()
# ggplot(smaller_uncertain_diamonds, aes(carat)) +
#   geom_bar_sample(alpha=0.1) +
#   scale_x_binned()



# NEED NESTED POSITION STACK_DODGE OR STACK_IDENTITY FOR THIS TO WORK
# # Rather than stacking histograms, it's easier to compare frequency
# # polygons
# ggplot(smaller_diamonds, aes(price, fill = cut)) +
#   geom_histogram(binwidth = 500)
# ggplot(smaller_uncertain_diamonds, aes(price, fill = cut)) +
#   geom_histogram_sample(binwidth = 500, alpha=0.1)



# # THIS SECTION DOES MATH, NOT FOR DISTRIBUTIONS
# # When using the non-equal-width bins, we should set the area of the bars to
# # represent the counts (not the height).
# # Here we're using 10 equi-probable bins:
# price_bins <- quantile(smaller_diamonds$price, probs = seq(0, 1, length = 11))
# 
# ggplot(smaller_diamonds, aes(price)) +
#   geom_histogram(breaks = price_bins, color = "black") # misleading (height = count)
# 
# ggplot(smaller_diamonds, aes(price, after_stat(count / width))) +
#   geom_histogram(breaks = price_bins, color = "black") # area = count



# # THIS SECTION USES A HUGE DATA SET, 
# # I AM NOT DOING THAT GGDIBBLER WILL DIE
# if (require("ggplot2movies")) {
#   # Often we don't want the height of the bar to represent the
#   # count of observations, but the sum of some other variable.
#   # For example, the following plot shows the number of movies
#   # in each rating.
#   m <- ggplot(movies, aes(rating))
#   m + geom_histogram(binwidth = 0.1)
#   
#   # If, however, we want to see the number of votes cast in each
#   # category, we need to weight by the votes variable
#   m +
#     geom_histogram(aes(weight = votes), binwidth = 0.1) +
#     ylab("votes")
#   
#   # For transformed scales, binwidth applies to the transformed data.
#   # The bins have constant width on the transformed scale.
#   m +
#     geom_histogram() +
#     scale_x_log10()
#   m +
#     geom_histogram(binwidth = 0.05) +
#     scale_x_log10()
#   
#   # For transformed coordinate systems, the binwidth applies to the
#   # raw data. The bins have constant width on the original scale.
#   
#   # Using log scales does not work here, because the first
#   # bar is anchored at zero, and so when transformed becomes negative
#   # infinity. This is not a problem when transforming the scales, because
#   # no observations have 0 ratings.
#   m +
#     geom_histogram(boundary = 0) +
#     coord_transform(x = "log10")
#   # Use boundary = 0, to make sure we don't take sqrt of negative values
#   m +
#     geom_histogram(boundary = 0) +
#     coord_transform(x = "sqrt")
#   
#   # You can also transform the y axis.  Remember that the base of the bars
#   # has value 0, so log transformations are not appropriate
#   m <- ggplot(movies, aes(x = rating))
#   m +
#     geom_histogram(binwidth = 0.5) +
#     scale_y_sqrt()
# }


############## UNTESTED #################









