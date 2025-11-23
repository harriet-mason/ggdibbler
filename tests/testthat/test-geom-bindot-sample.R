library(vdiffr)
library(ggplot2)

suppressMessages({
test_that("geom_dotplot_sample tests", {

  set.seed(783)
  p1 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(alpha=0.2)
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, alpha=0.2)
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(method="histodot", binwidth = 1.5, 
                        alpha=0.2)
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, stackdir = "center", alpha=0.2)
  expect_doppelganger("Example 4", p4)
  
  p5 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, stackdir = "centerwhole",
                        alpha=0.2)
  expect_doppelganger("Example 5", p5)
  
  p6 <- ggplot(uncertain_mtcars, aes(x = mpg)) + 
    geom_dotplot_sample(binwidth = 1.5, alpha=0.2) 
  expect_doppelganger("Example 6", p6)
  
  p7 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, stackratio = .7,
                        alpha=0.2)
  expect_doppelganger("Example 7", p7)
  
  p8 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, dotsize = 1.25,
                        alpha=0.2)
  expect_doppelganger("Example 8", p8)
  
  p9 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, fill = "white", stroke = 2,
                        alpha=0.2)
  expect_doppelganger("Example 9", p9)
  
  p10 <- ggplot(uncertain_mtcars, aes(x = 1, y = mpg)) +
    geom_dotplot_sample(binaxis = "y", stackdir = "center",
                        alpha=0.2) 
  expect_doppelganger("Example 10", p10)

}
)
})

################ PASS #################


############### FAIL #################
# ALL THESE EXAMPLES REQUIRE YOU TO FACTOR A CONTINUOUS VARIABLE

# # y must be a factor for this to work. dist_transform should work
# # idk why it doesnt. would be a scale problem I think
# ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
#   geom_dotplot(binaxis = "y", stackdir = "center")
# # ggdibbler
# ggplot(uncertain_mtcars, aes(x = distributional::dist_transformed(cyl, as.factor, as.integer), 
#                              y = mpg)) +
#   geom_dotplot_sample(binaxis = "y", stackdir = "center", alpha=0.2) +
#   scale_y_continuous_distribution(limits=c(9, 36)) +
#   scale_x_continuous_distribution(limits=c(2, 10))
# 
# ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
#   geom_dotplot(binaxis = "y", stackdir = "centerwhole")
# 
# ggplot(mtcars, aes(x = factor(vs), fill = factor(cyl), y = mpg)) +
#   geom_dotplot(binaxis = "y", stackdir = "center", position = "dodge")
# 
# # binpositions="all" ensures that the bins are aligned between groups
# ggplot(mtcars, aes(x = factor(am), y = mpg)) +
#   geom_dotplot(binaxis = "y", stackdir = "center", binpositions="all")
# 
# # Stacking multiple groups, with different fill
# ggplot(mtcars, aes(x = mpg, fill = factor(cyl))) +
#   geom_dotplot(stackgroups = TRUE, binwidth = 1, binpositions = "all")
# 
# ggplot(mtcars, aes(x = mpg, fill = factor(cyl))) +
#   geom_dotplot(stackgroups = TRUE, binwidth = 1, method = "histodot")
# 
# ggplot(mtcars, aes(x = 1, y = mpg, fill = factor(cyl))) +
#   geom_dotplot(binaxis = "y", stackgroups = TRUE, binwidth = 1, method = "histodot")

############## UNTESTED #################






