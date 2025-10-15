set.seed(28)
test_data <- data.frame(
  bob = c(distributional::dist_uniform(2,3), 
          distributional::dist_normal(3,2), 
          distributional::dist_exponential(3)),
  john = c(distributional::dist_gamma(2,1), 
           distributional::dist_normal(5,1), 
           distributional::dist_exponential(1)),
  ken = c(1,2,3),
  rob = c("A", "B", "C")
)

library(distributional)
test2 <- data.frame(
  bob = c(dist_normal(-1,1), 
          dist_normal(0,1),
          dist_normal(1,1)),
  john = c(dist_normal(10,1), 
           dist_normal(11,1), 
           dist_normal(12,1)))

test_that("stat_sample tests", {
  set.seed(1)
  # basic check with dist x and y
  # no random variables used - just return normal points
  p1 <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, 
                ggplot2::aes(x=ken, y=rob, colour=rob))
  
  # random variables x and y
  p2a <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, 
                      ggplot2::aes(x=bob, y=john))
  p2b <- ggplot2::ggplot() + 
    geom_sample_point(data = test2, 
                      ggplot2::aes(x=bob, y=john))
  
  # random variables only x
  p3 <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, ggplot2::aes(x=bob, y=ken))
  
  # deterministic colour, random x and y
  p4 <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, ggplot2::aes(x=bob, y=john, colour=rob))
  
  # colour by distribution
  p5 <- ggplot2::ggplot() + 
    stat_sample(data = test_data, ggplot2::aes(x=bob, y=john, colour=as.factor(john)))
  
  # random y and colour, deterministic x
  p6 <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, ggplot2::aes(x=ken, y=bob, colour=john))
  # works when variable is just colour. Does weird identity colour thing for colourdist
  # no colour scale?? it works for geom_sf. Look into it
  
  # random colour only + jitter
  p7 <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, ggplot2::aes(x=ken, y=rob, colour=john),
                position=ggplot2::position_jitter(width=0.1, height=0.1))
  # should add jitter position dodge doesnt work very well. look into it.

  
  # geom text
  ggplot2::ggplot() + 
    stat_sample(data = test_data, ggplot2::aes(x=bob, y=john, label=rob), geom="text")
  
  # BUG - HMMM NOT SURE I WANT IT APPEARING 3 TIMES
  p8 <- ggplot2::ggplot() + 
    geom_sample_point(data = test_data, ggplot2::aes(x=john, y=bob, colour=rob)) +
    stat_sample(data = test_data, ggplot2::aes(intercept=bob, slope = 1, colour=rob),  geom=ggplot2::GeomAbline,
                times=3)
}
)

test_that("stat_sample alternative geom tests", {
  set.seed(1)
  # geom text
  p1 <- ggplot2::ggplot() + 
    stat_sample(data = test2, ggplot2::aes(x=bob, y=john, label=ggplot2::after_stat(x)), geom="text")
  
  # geom_abline - Janky ass axis
  p2 <- ggplot2::ggplot() + 
    stat_sample(data = test_data, ggplot2::aes(intercept=john), slope=5, geom=GeomAbline)
  
  # geom col
  p3 <- ggplot2::ggplot() + 
    stat_sample(data = test_data, ggplot2::aes(x=ken, y=john, fill=rob), geom="col", times=100)
}
)
