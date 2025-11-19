# Subdivide position aesthetic in a geometry

If the outline of a polygon is deterministic but the fill is random, you
should use position subdivide rather than varying the alpha value. This
subdivide position can be used with geom_polygon_sample (soon to be
extended to others such as geom_sf, geom_map, etc).

## Usage

``` r
position_identity_subdivide()
```

## Examples

``` r
library(ggplot2)
library(distributional)
library(dplyr)

# make data polygon with uncertain fill values
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
datapoly <- merge(values, positions, by = c("id"))
uncertain_datapoly2 <- datapoly |>
  mutate(value = dist_uniform(value-0.5, value + 0.5)) 
  
# visualise with geom_polygon
ggplot(uncertain_datapoly2 , aes(x = x, y = y)) +
  geom_polygon_sample(aes(fill = value, group = id), times=50,
                      position = "identity_subdivide")
```
