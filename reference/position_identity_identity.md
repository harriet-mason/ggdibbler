# Nested identity positions

These functions use nested positioning for distributional data, where
the original plot has a identity position. This allows you to set
different position adjustments for the "main" and "distribution" parts
of your plot.

## Usage

``` r
position_identity_identity()

position_identity_dodge(
  width = NULL,
  preserve = "single",
  orientation = "x",
  reverse = FALSE
)
```

## Arguments

- width:

  Dodging width, when different to the width of the individual elements.
  This is useful when you want to align narrow geoms with wider geoms.
  See the examples.

- preserve:

  Should dodging preserve the `"total"` width of all elements at a
  position, or the width of a `"single"` element?

- orientation:

  Fallback orientation when the layer or the data does not indicate an
  explicit orientation, like
  [`geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).
  Can be `"x"` (default) or `"y"`.

- reverse:

  If `TRUE`, will reverse the default stacking order. This is useful if
  you're rotating both the plot and legend.

- vjust:

  Vertical adjustment for geoms that have a position (like points or
  lines), not a dimension (like bars or areas). Set to `0` to align with
  the bottom, `0.5` for the middle, and `1` (the default) for the top.

## Examples

``` r
# Standard ggplots often have a position adjustment to fix overplotting
# plot with overplotting
library(ggplot2)
ggplot(mpg, aes(class)) + 
  geom_bar(aes(fill = drv), alpha=0.5,
           position = "identity")


# sometimes ggdibbler functions call for more control over these 
# overplotting adjustments
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "identity", alpha=0.1)

# is the same as...
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "identity_identity", alpha=0.1)

  
# nested positions allows us to differentiate which postion adjustments
# are used for the plot groups vs the distribution samples
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "identity_dodge", alpha=0.7)
```
