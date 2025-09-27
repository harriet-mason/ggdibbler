# code that generates warning
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

test_that("collect_warning tests", {
  # Generates warning
  p <- ggplot2::ggplot() + 
    stat_sample(data = test_data, ggplot2::aes(x=bob, y=john))
  
  # Both Normal warning and bad warning
  p <- ggplot2::ggplot() + 
    stat_sample(data = test_data2, ggplot2::aes(x=bob, y=john, colour=rob))
  
  # Actual mistake
  p <- ggplot2::ggplot() + 
    stat_sample(data = test_data, ggplot2::aes(x=bob, y=john, flat = rob))
})