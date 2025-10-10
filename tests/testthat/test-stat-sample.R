# Distribution data frame to test stat-sample
named_data <- data.frame(
  xdist = c(distributional::dist_uniform(2,3), 
        distributional::dist_normal(3,2), 
        distributional::dist_exponential(3)),
  ydist = c(distributional::dist_gamma(2,1), 
        distributional::dist_normal(5,1), 
        distributional::dist_exponential(1)),
  colour = c(1,2,3)
)

test_that("StatSample tests", {
  set.seed(1)
  check <- StatSample$compute_group(named_data, n=100)
  
  # basic check with dist x and y
  p1 <- ggplot2::ggplot() +
    ggplot2::geom_point(data = check, ggplot2::aes(x=x, y=y, colour=colour))
  vdiffr::expect_doppelganger("Basic StatSample check", p1)
}
)


#ggplot2::ggplot() + stat_sample(data = named_data, ggplot2::aes(x=x, y=y, colour=colour))
