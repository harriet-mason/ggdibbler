# load libraries
library(ggplot2)
library(distributional)
library(vdiffr)

test_that("geom_count_sample tests", {
  # no random variables used - just return normal points
  set.seed(27102025)
  p1 <- ggplot(uncertain_mpg, aes(cty, hwy)) +
    geom_count_sample(alpha=0.2) 
  expect_doppelganger("example1", p1)
  
  # random variables x and y
  p2 <- ggplot(uncertain_mpg, aes(cty, hwy)) +
    geom_count_sample(alpha=0.2) +
    scale_size_area()
  expect_doppelganger("example2", p2)
}
)
# 
# # By default, all categorical variables in the plot form the groups.
# # Specifying geom_count without a group identifier leads to a plot which is
# # not useful:
# d <- ggplot(smaller_diamonds, aes(x = cut, y = clarity))
# d + geom_count(aes(size = after_stat(prop)))
# 
# q <- ggplot(smaller_uncertain_diamonds, aes(x = cut, y = clarity))
# q + geom_count_sample(aes(size = after_stat(prop)), alpha=0.1)
# # To correct this problem and achieve a more desirable plot, we need
# # to specify which group the proportion is to be calculated over.
# d + geom_count(aes(size = after_stat(prop), group = 1)) +
#   scale_size_area(max_size = 10)
# 
# # Or group by x/y variables to have rows/columns sum to 1.
# d + geom_count(aes(size = after_stat(prop), group = cut)) +
#   scale_size_area(max_size = 10)
# d + geom_count(aes(size = after_stat(prop), group = clarity)) +
#   scale_size_area(max_size = 10)