library(vdiffr)
library(ggplot2)

# ################ PASS #################

uncertain_mpg$drv2 <- mpg$drv

suppressMessages({
test_that("geom_smooth_sample tests", {

  set.seed(573)
  
  p1 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1)
  
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1, orientation = "y")+
    scale_y_continuous_distribution(limits=c(12,46)) +
    scale_x_continuous_distribution(limits=c(1,7))
  
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1, span = 0.3)+
    scale_y_continuous_distribution(limits=c(12,46)) +
    scale_x_continuous_distribution(limits=c(1,7))
  
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    geom_smooth(method = lm, se = FALSE)
  
  expect_doppelganger("Example 4", p4)
  
  p5 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1, method = lm, se = FALSE)+
    scale_y_continuous_distribution(limits=c(12,46)) +
    scale_x_continuous_distribution(limits=c(1,7))
  
  expect_doppelganger("Example 5", p5)
  
  p6 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1,
                       method = lm, formula = y ~ splines::bs(x, 3), se = FALSE)+
    scale_y_continuous_distribution(limits=c(12,46)) +
    scale_x_continuous_distribution(limits=c(1,7))
  
  expect_doppelganger("Example 6", p6)
  
  
  p7 <- ggplot(uncertain_mpg, aes(displ, hwy, colour = class)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1, se = FALSE, method = lm) +
    scale_y_continuous_distribution(limits=c(12,46)) +
    scale_x_continuous_distribution(limits=c(1,7))
  
  expect_doppelganger("Example 7", p7)
  
  p8 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1, span = 0.8) +
    facet_wrap(~drv2)
  
  expect_doppelganger("Example 8", p8)

}
)
}
)

# ############### FAIL #################
# ############## UNTESTED #################


# Didn't bother with this because it seems convoluted and also involves math
# binomial_smooth <- function(...) {
#   geom_smooth(method = "glm", method.args = list(family = "binomial"), ...)
# }
# # To fit a logistic regression, you need to coerce the values to
# # a numeric vector lying between 0 and 1.
# ggplot(rpart::kyphosis, aes(Age, Kyphosis)) +
#   geom_jitter(height = 0.05) +
#   binomial_smooth()
# 
# ggplot(rpart::kyphosis, aes(Age, as.numeric(Kyphosis) - 1)) +
#   geom_jitter(height = 0.05) +
#   binomial_smooth()
# 
# ggplot(rpart::kyphosis, aes(Age, as.numeric(Kyphosis) - 1)) +
#   geom_jitter(height = 0.05) +
#   binomial_smooth(formula = y ~ splines::ns(x, 2))
# 
# # But in this case, it's probably better to fit the model yourself
# # so you can exercise more control and see whether or not it's a good model.
# 
# # smaller case to see high variance
# smaller_uncertain_df <- uncertain_mpg %>% 
#   sample_n(20) 
# ggplot(smaller_uncertain_df, aes(displ, hwy)) +
#   geom_point_sample(alpha=0.5, size=0.2) + 
#   geom_smooth_sample(linewidth=0.2, alpha=0.1) 