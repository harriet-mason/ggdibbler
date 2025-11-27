
suppressWarnings({
library(vdiffr)
library(ggplot2)
  test_that("stat_summary_bin_sample tests", {
    
    set.seed(123)
    p1 <- ggplot(smaller_uncertain_diamonds, aes(carat, price)) +
      stat_summary_bin_sample(fun = "mean", geom="point")
     expect_doppelganger("Example 1", p1)
    }
  )
})



