library(vdiffr)

test_that("geom_**_sample tests", {
  
  set.seed(***)
  
  expect_doppelganger("Example 1", p1)
  
}
)

################ PASS #################
############### FAIL #################
############## UNTESTED #################
d <- ggplot(smaller_diamonds, aes(x, y)) 
d + geom_bin_2d()

b <- ggplot(smaller_uncertain_diamonds, aes(x, y)) 
# default position adjustment is dodging
b + geom_bin_2d_sample()
b + geom_bin_2d_sample(position="identity", alpha=0.2)

# You can control the size of the bins by specifying the number of
# bins in each direction:
d + geom_bin_2d(bins = 10)
d + geom_bin_2d(bins = list(x = 30, y = 10))

# Or by specifying the width of the bins
d + geom_bin_2d(binwidth = c(0.1, 0.1))

