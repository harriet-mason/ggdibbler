# Nested stack positions

These functions use nested positioning for distributional data, where
one of the positions is stacked. This allows you to set different
position adjustments for the "main" and "distribution" parts of your
plot.

## Usage

``` r
position_stack_identity(vjust = 1, reverse = FALSE)

position_stack_dodge(
  vjust = 1,
  reverse = FALSE,
  width = NULL,
  preserve = "single",
  orientation = "x"
)
```

## Arguments

- vjust:

  Vertical adjustment for geoms that have a position (like points or
  lines), not a dimension (like bars or areas). Set to `0` to align with
  the bottom, `0.5` for the middle, and `1` (the default) for the top.

- reverse:

  If `TRUE`, will reverse the default stacking order. This is useful if
  you're rotating both the plot and legend.

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

## Value

A ggplot2 position

## Examples

``` r
# Standard ggplots often have a position adjustment to fix overplotting
# plot with overplotting
library(ggplot2)
ggplot(mpg, aes(class)) + 
  geom_bar(aes(fill = drv),
           position = "stack")


# normal stack warps the scale and doesn't communicate useful info
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack")


# stack_identity
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_identity", alpha=0.2)

  
# stack_dodge
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_dodge")
```
