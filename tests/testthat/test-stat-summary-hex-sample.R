library(ggplot2)
library(vdiffr)
b <- ggplot(smaller_uncertain_diamonds,
            aes(carat, depth, z = price))

test_that("stat_summary_bin_sample tests", {
  
  set.seed(554)
  p1 <- b + stat_summary_hex_sample()
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + stat_summary_hex_sample(fun = ~ sum(.x^2))
  expect_doppelganger("Example 2", p2)
  
}
)


