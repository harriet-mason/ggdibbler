
test_that("geom_tile_sample tests", {
  set.seed(443)
  
  p1 <- ggplot(uncertain_mpg, aes(class)) + 
    geom_bar_sample(aes(fill = drv), 
                    position = position_nest("stack_dodge"))
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_mpg, aes(class)) + 
    geom_bar_sample(aes(fill = drv), 
                    position = position_nest("dodge_dodge"))
  expect_doppelganger("Example 2", p2)
}
)


