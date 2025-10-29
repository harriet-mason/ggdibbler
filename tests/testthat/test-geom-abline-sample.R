# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################
# library(ggplot2)
# p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
# p + geom_abline() # Can't see it - outside the range of the data
# p + geom_abline(intercept = 20)
# 
# q <- ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample()
# q + geom_abline_sample() # Can't see it - outside the range of the data
# q + geom_abline_sample(intercept = 20)
# 
# coef(lm(mpg ~ wt, data = mtcars))
# p + geom_abline(intercept = 37, slope = -5)
# 
# uncertain_mpg |>
#   sample_expand(times=100) |>
#   group_by()
# coef(lm( ~ wt, data = mtcars))
# 
# # Fixed values
# p + geom_vline(xintercept = 5)
# p + geom_vline(xintercept = 1:5)
# p + geom_hline(yintercept = 20)
# 
# 
# 
# # Calculate slope and intercept of line of best fit
# 
# # But this is easier to do with geom_smooth:
# p + geom_smooth(method = "lm", se = FALSE)
# 
# # To show different lines in different facets, use aesthetics
# p <- ggplot(mtcars, aes(mpg, wt)) +
#   geom_point() +
#   facet_wrap(~ cyl)
# 
# mean_wt <- data.frame(cyl = c(4, 6, 8), wt = c(2.28, 3.11, 4.00))
# p + geom_hline(aes(yintercept = wt), mean_wt)
# 
# # You can also control other aesthetics
# ggplot(mtcars, aes(mpg, wt, colour = wt)) +
#   geom_point() +
#   geom_hline(aes(yintercept = wt, colour = wt), mean_wt) +
#   facet_wrap(~ cyl)
