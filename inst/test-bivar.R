# checking code
# get distribution vector
x <- toy_temp_dist$temp_dist
# bivariate output from distribution
a <- bivariate(x)

# get it in 2 variable format
x <- data.frame(
  est_mean = distributional:::mean.distribution(x),
  std_err = distributional::variance(x)
)
# new bivariate from data frame
b <- new_bivariate(x)

test_that("new_bivariate", {
})


test_that("bivariate", {
  x <- toy_temp_dist$temp_dist
  # bivariate output from distribution
  a <- bivariate(x)
})

test_that("is_bivariate", {
})

#expect_s3_class()

