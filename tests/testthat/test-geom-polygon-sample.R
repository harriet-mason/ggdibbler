# load vdiffr package
library(vdiffr)

# data set up
library(ggplot2)
library(distributional)
library(dplyr)

ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))

values <- data.frame(
  id = ids,
  value = c(3, 3.1, 3.1, 3.2, 3.15, 3.5)
)
positions <- data.frame(
  id = rep(ids, each = 4),
  x = c(2, 1, 1.1, 2.2, 1, 0, 0.3, 1.1, 2.2, 1.1, 1.2, 2.5, 1.1, 0.3,
        0.5, 1.2, 2.5, 1.2, 1.3, 2.7, 1.2, 0.5, 0.6, 1.3),
  y = c(-0.5, 0, 1, 0.5, 0, 0.5, 1.5, 1, 0.5, 1, 2.1, 1.7, 1, 1.5,
        2.2, 2.1, 1.7, 2.1, 3.2, 2.8, 2.1, 2.2, 3.3, 3.2)
)
# Currently we need to manually merge the two together
datapoly <- merge(values, positions, by = c("id"))

# Make uncertain version of datapoly
uncertain_datapoly <- datapoly |>
  mutate(x = dist_uniform(x-0.1, x + 0.1),
         y = dist_uniform(y-0.1, y + 0.1),
         value = dist_uniform(value-0.1, value + 0.1))

# line
set.seed(1)
stream <- data.frame(
  x = cumsum(runif(50, max = 0.1)),
  y = cumsum(runif(50,max = 0.1))
)
# uncertain line
uncertain_stream <- stream |>
  mutate(x = dist_normal(x, 0.1),
         y = dist_normal(y, 0.1))


test_that("geom_polygon_sample examples", {
  
  set.seed(323)
  
  q0 <- ggplot(datapoly, aes(x = x, y = y)) +
    geom_polygon_sample(aes(fill = value, group = id), alpha=1)
  
  expect_doppelganger("deterministic", q0)
  
  q1 <- ggplot(uncertain_datapoly, aes(x = x, y = y)) +
    geom_polygon_sample(aes(fill = value, group = id))
  
  expect_doppelganger("random polygon", q1)
  
  q2 <- q1 + 
    geom_line(data = stream, colour = "grey30", linewidth = 5)

  expect_doppelganger("add to coordinate", q2)
}
)

