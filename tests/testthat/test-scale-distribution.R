# load libraries
library(ggplot2)
library(distributional)

# make data
set.seed(1997)
point_data <- data.frame(xvar = c(dist_uniform(2,3),dist_normal(3,2),dist_exponential(3)),
                         yvar = c(dist_gamma(2,1), dist_sample(x = list(rnorm(100, 5, 1))), dist_exponential(1)))

test_that("geom_point_sample tests", {
  set.seed(1)
  # no random variables used - just return normal points
  p1 <- ggplot(data = point_data) + 
    geom_point_sample(aes(x=xvar, y=yvar)) +
    scale_x_continuous_distribution(name="Hello, I am a random variable", limits = c(-5, 10)) +
    scale_y_continuous_distribution(name="I am also a random variable")
  expect_doppelganger("basic scale_x_distribution test", p1)
}
)