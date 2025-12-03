# Nested dodge positions

These functions use nested positioning for distributional data, where
one of the positions is dodged. This allows you to set different
position adjustments for the "main" and "distribution" parts of your
plot.

## Usage

``` r
position_dodge_dodge(
  width = NULL,
  preserve = "single",
  orientation = "x",
  reverse = FALSE
)

position_dodge_identity(
  width = NULL,
  preserve = "single",
  orientation = "x",
  reverse = FALSE
)

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

## Value

A ggplot2 position

## Aesthetics

[`position_dodge()`](https://ggplot2.tidyverse.org/reference/position_dodge.html)
understands the following aesthetics. Required aesthetics are displayed
in bold and defaults are displayed for optional aesthetics:

|     |         |          |
|-----|---------|----------|
| •   | `order` | → `NULL` |

Learn more about setting these aesthetics in
[`vignette("ggplot2-specs")`](https://ggplot2.tidyverse.org/articles/ggplot2-specs.html).

## Examples

``` r
library(ggplot2)

# ggplot dodge 
ggplot(mpg, aes(class)) + 
  geom_bar(aes(fill = drv), 
           position = position_dodge(preserve = "single"))

           
# normal dodge without nesting
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge")

  
# dodge_identity
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_identity", alpha=0.2)


# dodge_dodge
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_dodge")


# identity_dodge 
ggplot(mpg, aes(class)) + 
  geom_bar(aes(fill = drv), alpha=0.5, position = "identity")

ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "identity_dodge", alpha=0.7)

  
```
