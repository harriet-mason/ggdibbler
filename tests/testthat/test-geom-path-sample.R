library(vdiffr)
library(ggplot2)
library(mutate)
library(distributional)

test_that("geom_line_path_step_sample tests", {
  # no random variables used - just return normal points
  set.seed(24)
  # deterministic tests
  p1 <- ggplot(economics, aes(date, unemploy)) + 
    geom_line_sample()
  expect_doppelganger("example1", p1)
  
  p2 <- ggplot(economics, aes(date, unemploy)) + 
    geom_step_sample()
  expect_doppelganger("example2", p2)
  
  p3 <- ggplot(economics, aes(date, unemploy)) + 
    geom_path_sample()
  expect_doppelganger("example3", p3)
  
  p4 <- ggplot(uncertain_economics, aes(date, unemploy)) + 
    geom_line_sample(alpha=0.1) 
  expect_doppelganger("example4", p4)
  
  p5 <- ggplot(uncertain_economics, aes(unemploy, date)) + 
    geom_line_sample(orientation = "y", alpha=0.1)
  expect_doppelganger("example5", p5)
  
  uncertain_recent <- uncertain_economics[uncertain_economics$date > as.Date("2013-01-01"), ]
  
  p6 <- ggplot(uncertain_recent, aes(date, unemploy)) + 
    geom_line_sample(alpha=0.3) #ggdibbler
  expect_doppelganger("example6", p6)
  
  p7 <- ggplot(uncertain_recent, aes(date, unemploy)) + 
    geom_step_sample(alpha=0.3) #ggdibbler
  expect_doppelganger("example7", p7)
  
  p8 <- ggplot(uncertain_economics, aes(date, unemploy)) +
    geom_line_sample(colour = "red", alpha=0.1)
  expect_doppelganger("example8", p8)
  
  p9 <- ggplot(uncertain_economics, aes(x = date, y = pop)) + 
    geom_line_sample(arrow = arrow(), alpha=0.1)
  expect_doppelganger("example9", p9)
  
  p10 <- ggplot(uncertain_economics, aes(x = date, y = pop)) +
    geom_line_sample(arrow = arrow(angle = 15, ends = "both", type = "closed"),
                     alpha=0.1)
  expect_doppelganger("example10", p10)
  
  p11 <- ggplot(uncertain_economics_long, aes(date, value0, colour = variable)) +
    geom_line_sample(key_glyph = "timeseries", alpha=0.1) 
  expect_doppelganger("example11", p11)
  
  p12 <- ggplot(uncertain_economics, aes(unemploy, psavert))
  expect_doppelganger("example12", p12)
  
  p13 <- p12 + geom_path_sample(alpha=0.3)
  expect_doppelganger("example13", p13)
  
  p14 <- p12  + geom_path_sample(aes(colour = as.numeric(date)), alpha=0.3)
  expect_doppelganger("example14", p14)
  
  uncertain_df <- df |> mutate(y=dist_normal(y, 0.3))
  p15 <- ggplot(uncertain_df, aes(x, y)) + geom_point_sample() + geom_line_sample() 
  expect_doppelganger("example15", p15)
  
}
)

