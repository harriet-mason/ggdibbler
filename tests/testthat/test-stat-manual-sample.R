library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)

q <- ggplot(uncertain_mtcars, 
            aes(disp, mpg, 
                colour = dist_transformed(cyl, factor, as.numeric))) +
  labs(colour="factor(cyl)") +
  geom_point_sample()

make_hull <- function(data) {
  hull <- chull(x = data$x, y = data$y)
  data.frame(x = data$x[hull], y = data$y[hull])
}


test_that("stat_manual_sample tests", {
  
  set.seed(888)
  
  p1 <- q + stat_manual_sample()
  expect_doppelganger("Example 1", p1)
  
  p2 <- q + stat_manual_sample(
    geom = "polygon",
    fun  = make_hull,
    fill = NA
  )
  expect_doppelganger("Example 2", p2)
  
  p3 <- q + stat_manual_sample(
    geom = "segment",
    fun  = transform,
    args = list(
      xend = quote(mean(x)),
      yend = quote(mean(y))
    )
  )
  expect_doppelganger("Example 3", p3)
  
  p4 <- q + stat_manual_sample(
    size = 10, shape = 21,
    fun  = dplyr::summarise,
    args = vars(x = mean(x), y = mean(y))
  )
  expect_doppelganger("Example 4", p4)
  
  
}
)
