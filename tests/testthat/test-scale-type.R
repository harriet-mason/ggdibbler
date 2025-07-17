library(distributional)

test_that("Sample Distributions", {
  # Numerical sample
  dist1 <- dist_sample(x = list(rnorm(100), rnorm(100, 10)))
  expect_equal(scale_type.distribution(dist1), "continuous")
  
  # Categorical Sample
  dist2 <- dist_sample(list(c("cat", "dog", "hen", "hen", "cat")))
  expect_equal(scale_type.distribution(dist2), "discrete")
})

test_that("Standard Distributions", {
  # Normal dist
  dist1 <- dist_normal(mu = 1:5, sigma = 3)
  expect_equal(scale_type.distribution(dist1), "continuous")
  
  # Binomial
  dist2 <- dist_binomial(size = 1:5, prob = c(0.05, 0.5, 0.3, 0.9, 0.1))
  expect_equal(scale_type.distribution(dist2), "continuous")
  
  # Uniform
  dist3 <- dist_uniform(min = c(3, -2), max = c(5, 4))
  expect_equal(scale_type.distribution(dist3), "continuous")
})