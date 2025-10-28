library(vdiffr)
library(ggplot2)
library(distributional)
set.seed(911000)
df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
uncertain_df <-  data.frame(trt = c("a", "b", "c"), 
                            outcome = dist_normal(mean = c(2.3, 1.9, 3.2), sd = c(0.5, 0.8, 0.7)))

test_that("geom_**_sample tests", {
  # no random variables used - just return normal points
  p1 <- ggplot(uncertain_df, aes(x=trt, y=outcome)) +
    geom_col_sample(alpha=0.05, times=30)
  expect_doppelganger("example1", p1)
  
  # random variables x and y
  p2 <- ggplot(uncertain_df, aes(x=trt, y=outcome)) +
    geom_col_sample(times = 30, position = "dodge")
  expect_doppelganger("example2", p2)
}
)

