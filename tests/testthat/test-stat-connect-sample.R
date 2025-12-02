library(vdiffr)
library(ggplot2)

x <- seq(0, 1, length.out = 20)[-1]
smooth <- cbind(x, scales::rescale(1 / (1 + exp(-(x * 10 - 5)))))
zigzag <- cbind(c(0.4, 0.6, 1), c(0.75, 0.25, 1))

test_that("stat_connect_sample tests", {
  
  set.seed(5)
  
  p1 <- ggplot(head(uncertain_economics, 10), aes(date, unemploy)) +
    stat_connect_sample(aes(colour = "zigzag"), connection = zigzag, seed=64) +
    stat_connect_sample(aes(colour = "smooth"), connection = smooth, seed=64) +
    geom_point_sample(seed=64) 
  
  expect_doppelganger("Example 1", p1)
  
}
)





