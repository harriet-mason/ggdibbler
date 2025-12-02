library(vdiffr)
library(ggplot2)
library(dplyr)
library(distributional)

# data for last example
x <- seq(0.01, .99, length.out = 100)
df <- data.frame(
  x = rep(x, 2),
  y = c(qlogis(x), 2 * qlogis(x)),
  group = rep(c("a","b"),
              each = 100)
  )
uncertain_df <- df |> mutate(y=dist_normal(y, 0.3))

test_that("geom_line_path_step_sample tests", {
  # no random variables used - just return normal points
  set.seed(24)
  # deterministic tests
  
  p4 <- ggplot(uncertain_economics, aes(date, unemploy)) + 
    geom_line_sample() 
  expect_doppelganger("example4", p4)
  
  uncertain_recent <- uncertain_economics[uncertain_economics$date > as.Date("2013-01-01"), ]
  
  p7 <- ggplot(uncertain_recent, aes(date, unemploy)) + 
    geom_step_sample() #ggdibbler
  expect_doppelganger("example7", p7)
  
  p14 <- ggplot(uncertain_economics, aes(unemploy, psavert))  + 
    geom_path_sample(aes(colour = as.numeric(date)))
  expect_doppelganger("example14", p14)
  
  p15 <- ggplot(uncertain_df, aes(x, y)) + 
    geom_point_sample(seed=55) + 
    geom_line_sample(seed=55) 
  expect_doppelganger("example15", p15)
  
}
)

