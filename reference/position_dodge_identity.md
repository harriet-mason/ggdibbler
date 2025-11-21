# Nested dodge positions

These functions use nested positioning for distributional data, where
the original plot has a dodged position. This allows you to set
different position adjustments for the "main" and "distribution" parts
of your plot.

## Usage

``` r
position_dodge_dodge(
  vjust = 1,
  reverse = FALSE,
  width = NULL,
  preserve = "single",
  orientation = "x"
)

position_dodge_identity(
  width = NULL,
  preserve = "single",
  orientation = "x",
  reverse = FALSE
)
```

## Arguments

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

## Examples

``` r
# Standard ggplots often have a position adjustment to fix overplotting
# plot with dodged positions
library(ggplot2)
ggplot(mpg, aes(class)) + 
  geom_bar(aes(fill = drv), 
           position = position_dodge(preserve = "single"))


# but when we use this in ggdibbler, it can not work the way we expect
# normal dodge
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge")


# nested positions allows us to differentiate which postion adjustments
# are used for the plot groups vs the distribution samples

ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_identity", alpha=0.2)


# using postion_dodge nests the original plot group inside the distribtion 
# position dodge_dodge does the opposite nesting
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_dodge")

  
```
