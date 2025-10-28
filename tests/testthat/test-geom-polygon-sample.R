# load vdiffr package
library(vdiffr)
library(ggplot2)

# data set up
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
# ggplot
datapoly <- merge(values, positions, by = c("id"))
# ggdibbler
uncertain_datapoly <- datapoly |>
  mutate(x = dist_uniform(x-0.1, x + 0.1),
         y = dist_uniform(y-0.1, y + 0.1),
         value = dist_uniform(value-0.1, value + 0.1))

# Smaller working example
single_data <- datapoly |> filter(id %in% c("1.1", "1.2"))
single_uncertain_data <- uncertain_datapoly |> filter(id %in% c("1.1", "1.2"))

test_that("geom_polygon_sample examples", {
  
  set.seed(323)
  
  p1 <- ggplot(datapoly, aes(x = x, y = y)) +
    geom_polygon_sample(aes(group = id))
  expect_doppelganger("deterministic", p1)
  
  p2 <- ggplot(single_uncertain_data, aes(x = x, y = y)) +
    geom_polygon_sample(aes(group = id, fill=value), alpha=0.1, times=20)
  expect_doppelganger("example2", p2)
}
)

# ################ PASS #################

# ############### FAIL #################
# 
# # When using geom_polygon, you will typically need two data frames:
# # one contains the coordinates of each polygon (positions),  and the
# # other the values associated with each polygon (values).  An id
# # variable links the two together
# ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))
# values <- data.frame(
#   id = ids,
#   value = c(3, 3.1, 3.1, 3.2, 3.15, 3.5)
# )
# positions <- data.frame(
#   id = rep(ids, each = 4),
#   x = c(2, 1, 1.1, 2.2, 1, 0, 0.3, 1.1, 2.2, 1.1, 1.2, 2.5, 1.1, 0.3,
#         0.5, 1.2, 2.5, 1.2, 1.3, 2.7, 1.2, 0.5, 0.6, 1.3),
#   y = c(-0.5, 0, 1, 0.5, 0, 0.5, 1.5, 1, 0.5, 1, 2.1, 1.7, 1, 1.5,
#         2.2, 2.1, 1.7, 2.1, 3.2, 2.8, 2.1, 2.2, 3.3, 3.2)
# )
# # Currently we need to manually merge the two together
# datapoly <- merge(values, positions, by = c("id"))
# 
# p <- ggplot(datapoly, aes(x = x, y = y)) +
#   geom_polygon(aes(group = id), alpha=0.5)
# p
# 
# # ggdibbler
# library(distributional)
# library(dplyr)
# uncertain_datapoly <- datapoly |>
#   mutate(x = dist_uniform(x-0.1, x + 0.1),
#          y = dist_uniform(y-0.1, y + 0.1),
#          value = dist_uniform(value-0.1, value + 0.1))
# 
# # DOESNT EXIST WHEN TIMES = 1
# p <- ggplot(uncertain_datapoly, aes(x = x, y = y)) +
#   geom_polygon_sample(aes(group = id), alpha=0.1, times=1)
# p
# # DOES EXIST WHEN TIMES = 2
# p <- ggplot(uncertain_datapoly, aes(x = x, y = y)) +
#   geom_polygon_sample(aes(fill = value, group = id), alpha=0.1, times=2)
# p
# 
# 
# # ############## UNTESTED #################
# 
# 
# 
# # Which seems like a lot of work, but then it's easy to add on
# # other features in this coordinate system, e.g.:
# 
# set.seed(1)
# stream <- data.frame(
#   x = cumsum(runif(50, max = 0.1)),
#   y = cumsum(runif(50,max = 0.1))
# )
# 
# p + geom_line(data = stream, colour = "grey30", linewidth = 5)
# 
# # And if the positions are in longitude and latitude, you can use
# # coord_map to produce different map projections.
# 
# if (packageVersion("grid") >= "3.6") {
#   # As of R version 3.6 geom_polygon() supports polygons with holes
#   # Use the subgroup aesthetic to differentiate holes from the main polygon
#   
#   holes <- do.call(rbind, lapply(split(datapoly, datapoly$id), function(df) {
#     df$x <- df$x + 0.5 * (mean(df$x) - df$x)
#     df$y <- df$y + 0.5 * (mean(df$y) - df$y)
#     df
#   }))
#   datapoly$subid <- 1L
#   holes$subid <- 2L
#   datapoly <- rbind(datapoly, holes)
#   
#   p <- ggplot(datapoly, aes(x = x, y = y)) +
#     geom_polygon(aes(fill = value, group = id, subgroup = subid))
#   p
# }