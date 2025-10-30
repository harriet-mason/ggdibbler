library(vdiffr)
library(ggplot2)
library(distributional)
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point() 

test_that("geom_abhvline_sample tests", {
  
  set.seed(438)
  
  q1 <- ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample()
  expect_doppelganger("Example 1", q1)
  
  q2 <- q1 + geom_abline_sample() # Can't see it - outside the range of the data
  expect_doppelganger("Example 2", q2)
  
  q3 <- q1 + geom_abline_sample(intercept = dist_normal(20, 1))
  expect_doppelganger("Example 3", q3)
  
  q4 <- q1 + geom_vline_sample(xintercept = dist_normal(5, 0.1)) + 
    scale_x_continuous_distribution(limits = c(0,6)) + 
    scale_y_continuous_distribution(limits = c(10,35)) 
  expect_doppelganger("Example 4", q4)
  
  q5 <- q1 + geom_vline_sample(xintercept = dist_normal(1:5, 0.1)) 
  expect_doppelganger("Example 5", q5)
  
  q6 <- q1 + geom_hline_sample(yintercept = dist_normal(20, 1)) + 
    scale_x_continuous_distribution(limits = c(0,6)) + 
    scale_y_continuous_distribution(limits = c(10,35)) 
  expect_doppelganger("Example 6", q6)
  
  q7 <- p + geom_abline_sample(intercept = dist_normal(37, 1.8), slope = dist_normal(-5, 0.56),
                               times=30, alpha=0.1)
  expect_doppelganger("Example 7", q7)
  
}
)

# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################

# NEED GEOM SMOOTH TO RUN THIS CODE
# # But this is easier to do with geom_smooth:
# p + geom_smooth(method = "lm", se = FALSE)
# p + geom_smooth(method = "lm", se = TRUE)
# p + geom_smooth_sample(method = "lm", se = TRUE)

# NEED DETERMNISTIC AESTHETICS IN DATA SET FOR THIS CODE TO WORK
# To show different lines in different facets, use aesthetics
# p <- ggplot(mtcars, aes(mpg, wt)) +
#   geom_point() +
#   facet_wrap(~ cyl)
# mean_wt <- data.frame(cyl = c(4, 6, 8), wt = c(2.28, 3.11, 4.00))
# p + geom_hline(aes(yintercept = wt), mean_wt)
# 
# p <- ggplot(mtcars, aes(mpg, wt)) +
#   geom_point_sample(data= uncertain_mtcars) +
#   facet_wrap(~ mean(cyl))
# mean_wt <- data.frame(cyl = c(4, 6, 8), wt = c(2.28, 3.11, 4.00))
# p + geom_hline(aes(yintercept = wt), mean_wt)
# 
# # You can also control other aesthetics
# ggplot(mtcars, aes(mpg, wt, colour = wt)) +
#   geom_point() +
#   geom_hline(aes(yintercept = wt, colour = wt), mean_wt) +
#   facet_wrap(~ cyl)
