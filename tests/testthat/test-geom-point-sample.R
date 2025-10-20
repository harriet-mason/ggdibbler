# load ggplot2 and distributional
library(ggplot2)
library(distributional)
library(vdiffr)
# Make test data for geom_point_sample
set.seed(1997)
test_data <- data.frame(
  bob = c(dist_uniform(2,3),
               dist_normal(3,2), 
             dist_exponential(3)),
  john = c(dist_gamma(2,1),
             dist_sample(x = list(rnorm(100, 5, 1))),
             dist_exponential(1)),
  barry = dist_categorical(prob = list(c(0.8,0.15,0.05),
                                       c(0.25,0.7,0.05),
                                       c(0.25,0,0.75)), 
                           outcomes = list(c("A", "B", "C"))),
  ken = c(1,2,3),
  rob = c("A", "B", "C")
)
  

test_that("geom_point_sample tests", {
  set.seed(1)
  # no random variables used - just return normal points
  p1 <- ggplot() + 
    geom_point_sample(data = test_data, 
                aes(x=ken, y=rob, colour=rob)) 
  expect_doppelganger("all deterministic variables", p1)
  
  # random variables x and y
  p2 <- ggplot() + 
    geom_point_sample(data = test_data, 
                      aes(x=bob, y=john)) 
  expect_doppelganger("random variables x and y", p2)
  
  # random variables only x
  p3 <- ggplot() + 
    geom_point_sample(data = test_data, aes(x=bob, y=ken))
  expect_doppelganger("random variables only x", p3)
  
  # deterministic colour, random x and y
  p4 <- ggplot() + 
    geom_point_sample(data = test_data, aes(x=bob, y=john, colour=rob))
  expect_doppelganger("deterministic colour, random x and y", p4)
  
  # colour by distribution
  p5 <- ggplot() + 
    geom_point_sample(data = test_data, aes(x=bob, y=john, colour=as.factor(john)))
  expect_doppelganger("colour by distribution", p5)
  
  # random y and colour, deterministic x
  p6 <- ggplot() + 
    geom_point_sample(data = test_data, aes(x=ken, y=bob, colour=john))
  expect_doppelganger("random y and colour, deterministic x", p6)
  
  # random colour only + jitter
  p7 <- ggplot() + 
    geom_point_sample(data = test_data, aes(x=ken, y=rob, colour=barry),
                position=position_jitter(width=0.1, height=0.1))
  expect_doppelganger("random colour only + jitter", p7)
}
)
