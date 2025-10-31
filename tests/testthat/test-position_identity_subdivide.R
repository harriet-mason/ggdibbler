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
#' Currently we need to manually merge the two together
datapoly <- merge(values, positions, by = c("id"))

#' Make uncertain version of datapoly
uncertain_datapoly <- datapoly |>
  mutate(value = dist_uniform(value-0.1, value + 0.1))

ggplot(uncertain_datapoly, aes(x = x, y = y)) +
  geom_polygon_sample(aes(fill = value, group = id), alpha=0.1,
                      position = "identity_subdivide")


# simple case
simple <- uncertain_datapoly |> filter(id=="1.1")
ggplot(simple, aes(x = x, y = y)) +
  geom_polygon_sample(aes(fill = value, group = id), alpha=0.1,
                      position = "identity_subdivide")
