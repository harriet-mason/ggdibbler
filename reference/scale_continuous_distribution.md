# Position scales for continuous distributions

These scales allow for distributions to be passed to the x and y
position by mapping distribution objects to continuous aesthetics. These
scale can be used similarly to the scale\_\*\_continuous functions, but
they do not accept transformations. If you want to transform your scale,
you should apply a transformation through the coord\_\* functions, as
they are applied after the stat, so the existing ggplot infastructure
can be used. For example, if you would like a log transformation of the
x axis, plot + coord_transform(x = "log") would work fine.

## Usage

``` r
scale_x_continuous_distribution(
  name = waiver(),
  breaks = waiver(),
  labels = waiver(),
  limits = NULL,
  expand = waiver(),
  oob = oob_keep,
  guide = waiver(),
  position = "bottom",
  sec.axis = waiver(),
  ...
)

scale_y_continuous_distribution(
  name = waiver(),
  breaks = waiver(),
  labels = waiver(),
  limits = NULL,
  expand = waiver(),
  oob = scales::oob_keep,
  guide = waiver(),
  position = "left",
  sec.axis = waiver(),
  ...
)
```

## Arguments

- name:

  The name of the scale. Used as the axis or legend title. If
  [`waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html), the
  default, the name of the scale is taken from the first mapping used
  for that aesthetic. If `NULL`, the legend title will be omitted.

- breaks:

  One of:

  - `NULL` for no breaks

  - [`waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html)
    for the default breaks computed by the [transformation
    object](https://scales.r-lib.org/reference/new_transform.html)

  - A numeric vector of positions

  - A function that takes the limits as input and returns breaks as
    output (e.g., a function returned by
    [`scales::extended_breaks()`](https://scales.r-lib.org/reference/breaks_extended.html)).
    Note that for position scales, limits are provided after scale
    expansion. Also accepts rlang
    [lambda](https://rlang.r-lib.org/reference/as_function.html)
    function notation.

- labels:

  One of the options below. Please note that when `labels` is a vector,
  it is highly recommended to also set the `breaks` argument as a vector
  to protect against unintended mismatches.

  - `NULL` for no labels

  - [`waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html)
    for the default labels computed by the transformation object

  - A character vector giving labels (must be same length as `breaks`)

  - An expression vector (must be the same length as breaks). See
    ?plotmath for details.

  - A function that takes the breaks as input and returns labels as
    output. Also accepts rlang
    [lambda](https://rlang.r-lib.org/reference/as_function.html)
    function notation.

- limits:

  One of:

  - `NULL` to use the default scale range

  - A numeric vector of length two providing limits of the scale. Use
    `NA` to refer to the existing minimum or maximum

  - A function that accepts the existing (automatic) limits and returns
    new limits. Also accepts rlang
    [lambda](https://rlang.r-lib.org/reference/as_function.html)
    function notation. Note that setting limits on positional scales
    will **remove** data outside of the limits. If the purpose is to
    zoom, use the limit argument in the coordinate system (see
    [`coord_cartesian()`](https://ggplot2.tidyverse.org/reference/coord_cartesian.html)).

- expand:

  For position scales, a vector of range expansion constants used to add
  some padding around the data to ensure that they are placed some
  distance away from the axes. Use the convenience function
  [`expansion()`](https://ggplot2.tidyverse.org/reference/expansion.html)
  to generate the values for the `expand` argument. The defaults are to
  expand the scale by 5% on each side for continuous variables, and by
  0.6 units on each side for discrete variables.

- oob:

  One of:

  - Function that handles limits outside of the scale limits (out of
    bounds). Also accepts rlang
    [lambda](https://rlang.r-lib.org/reference/as_function.html)
    function notation.

  - The default
    ([`scales::censor()`](https://scales.r-lib.org/reference/oob.html))
    replaces out of bounds values with `NA`.

  - [`scales::squish()`](https://scales.r-lib.org/reference/oob.html)
    for squishing out of bounds values into range.

  - [`scales::squish_infinite()`](https://scales.r-lib.org/reference/oob.html)
    for squishing infinite values into range.

- guide:

  A function used to create a guide or its name. See
  [`guides()`](https://ggplot2.tidyverse.org/reference/guides.html) for
  more information.

- position:

  For position scales, The position of the axis. `left` or `right` for y
  axes, `top` or `bottom` for x axes.

- sec.axis:

  [`sec_axis()`](https://ggplot2.tidyverse.org/reference/sec_axis.html)
  is used to specify a secondary axis.

- ...:

  Other arguments passed on to `scale_(x|y)_continuous()`

## Value

A ggplot2 scale

## Examples

``` r
library(ggplot2)
library(distributional)
set.seed(1997)
point_data <- data.frame(xvar = c(dist_uniform(2,3),
                                  dist_normal(3,2),
                                  dist_exponential(3)),
                         yvar = c(dist_gamma(2,1), 
                                  dist_sample(x = list(rnorm(100, 5, 1))), 
                                  dist_exponential(1)))
ggplot(data = point_data) + 
  geom_point_sample(aes(x=xvar, y=yvar)) +
  scale_x_continuous_distribution(name="Hello, I am a random variable", limits = c(-5, 10)) +
  scale_y_continuous_distribution(name="I am also a random variable")

```
