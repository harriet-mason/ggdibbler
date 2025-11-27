library(vdiffr)
library(ggplot2)

sampled_rows_index <- sample(1:nrow(smaller_uncertain_diamonds), 
                             size = 100, replace = FALSE)
even_smaller_uncertain_diamonds <- smaller_uncertain_diamonds[sampled_rows_index, ]
b <- ggplot(even_smaller_uncertain_diamonds, aes(x, y)) 

suppressMessages({
test_that("geom_bin_2d_sample tests", {
  
  set.seed(999)
  
  p1 <- b + geom_bin_2d_sample()
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + geom_bin_2d_sample(position="identity", alpha=0.2)
  expect_doppelganger("Example 2", p2)
  
  p3 <- b + geom_bin_2d_sample(bins = 10) #ggdibbler
  expect_doppelganger("Example 3", p3)
  
}
)
})
