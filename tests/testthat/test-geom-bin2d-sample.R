library(vdiffr)

test_that("geom_**_sample tests", {
  
  set.seed(***)
  
  expect_doppelganger("Example 1", p1)
  
}
)

################ PASS #################
############### FAIL #################
############## UNTESTED #################
# ggplot
d <- ggplot(smaller_diamonds, aes(x, y)) 
d + geom_bin_2d()
# ggdibbler
b <- ggplot(smaller_uncertain_diamonds, aes(x, y)) 
  # the ggdibbler default position adjustment is dodging
b + geom_bin_2d_sample(times=100)
  # but it can change it to be transparency
b + geom_bin_2d_sample(position="identity", alpha=0.2)

# You can control the size of the bins by specifying the number of
# bins in each direction:
d + geom_bin_2d(bins = 10) #ggplot
b + geom_bin_2d_sample(bins = 10) #ggdibbler
d + geom_bin_2d(bins = list(x = 30, y = 10))
b + geom_bin_2d_sample(bins = list(x = 30, y = 10))
# Or by specifying the width of the bins
d + geom_bin_2d(binwidth = c(0.1, 0.1))
b + geom_bin_2d_sample(binwidth = c(0.1, 0.1))
