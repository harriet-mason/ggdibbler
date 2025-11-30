library(vdiffr)
library(ggplot2)

# single random variable data prep
uncertain_mpg_new <- uncertain_mpg
uncertain_mpg_new$class <- mpg$class
q <- ggplot(uncertain_mpg, aes(class, hwy))
# 
# suppressWarnings({
# test_that("geom_boxplot_sample tests", {
# 
#   set.seed(324)
#   
#   p1 <- q + geom_boxplot_sample(alpha=0.1, times=2)
#   expect_doppelganger("Example 1", p1)
#   
#   p5 <- q + geom_boxplot_sample(alpha=0.1, varwidth = TRUE, times=2)
#   expect_doppelganger("Example 5", p5)
# 
# }
# )
# })
