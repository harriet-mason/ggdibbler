# Uncertain Connected observations

Identical to geom_path, geom_line, and geom_step, except that it will
accept a distribution in place of any of the usual aesthetics.

## Usage

``` r
geom_path_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  position = "identity",
  ...,
  times = 10,
  alpha = 1/log(times),
  seed = NULL,
  arrow = NULL,
  arrow.fill = NULL,
  lineend = "butt",
  linejoin = "round",
  linemitre = 10,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

geom_line_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  position = "identity",
  ...,
  times = 10,
  alpha = 1/log(times),
  seed = NULL,
  orientation = NA,
  arrow = NULL,
  arrow.fill = NULL,
  lineend = "butt",
  linejoin = "round",
  linemitre = 10,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

geom_step_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  position = "identity",
  ...,
  times = 10,
  alpha = 1/log(times),
  seed = NULL,
  orientation = NA,
  lineend = "butt",
  linejoin = "round",
  linemitre = 10,
  arrow = NULL,
  arrow.fill = NULL,
  direction = "hv",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html). If
  specified and `inherit.aes = TRUE` (the default), it is combined with
  the default mapping at the top level of the plot. You must supply
  `mapping` if there is no plot mapping.

- data:

  The data to be displayed in this layer. There are three options:

  If `NULL`, the default, the data is inherited from the plot data as
  specified in the call to
  [`ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

  A `data.frame`, or other object, will override the plot data. All
  objects will be fortified to produce a data frame. See
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  for which variables will be created.

  A `function` will be called with a single argument, the plot data. The
  return value must be a `data.frame`, and will be used as the layer
  data. A `function` can be created from a `formula` (e.g.
  `~ head(.x, 10)`).

- stat:

  The statistical transformation to use on the data for this layer. When
  using a `geom_*()` function to construct a layer, the `stat` argument
  can be used to override the default coupling between geoms and stats.
  The `stat` argument accepts the following:

  - A `Stat` ggproto subclass, for example `StatCount`.

  - A string naming the stat. To give the stat as a string, strip the
    function name of the `stat_` prefix. For example, to use
    [`stat_count()`](https://ggplot2.tidyverse.org/reference/geom_bar.html),
    give the stat as `"count"`.

  - For more information and other ways to specify the stat, see the
    [layer
    stat](https://ggplot2.tidyverse.org/reference/layer_stats.html)
    documentation.

- position:

  A position adjustment to use on the data for this layer. This can be
  used in various ways, including to prevent overplotting and improving
  the display. The `position` argument accepts the following:

  - The result of calling a position function, such as
    [`position_jitter()`](https://ggplot2.tidyverse.org/reference/position_jitter.html).
    This method allows for passing extra arguments to the position.

  - A string naming the position adjustment. To give the position as a
    string, strip the function name of the `position_` prefix. For
    example, to use
    [`position_jitter()`](https://ggplot2.tidyverse.org/reference/position_jitter.html),
    give the position as `"jitter"`.

  - For more information and other ways to specify the position, see the
    [layer
    position](https://ggplot2.tidyverse.org/reference/layer_positions.html)
    documentation.

- ...:

  Other arguments passed on to
  [`layer()`](https://ggplot2.tidyverse.org/reference/layer.html)'s
  `params` argument. These arguments broadly fall into one of 4
  categories below. Notably, further arguments to the `position`
  argument, or aesthetics that are required can *not* be passed through
  `...`. Unknown arguments that are not part of the 4 categories below
  are ignored.

  - Static aesthetics that are not mapped to a scale, but are at a fixed
    value and apply to the layer as a whole. For example,
    `colour = "red"` or `linewidth = 3`. The geom's documentation has an
    **Aesthetics** section that lists the available options. The
    'required' aesthetics cannot be passed on to the `params`. Please
    note that while passing unmapped aesthetics as vectors is
    technically possible, the order and required length is not
    guaranteed to be parallel to the input data.

  - When constructing a layer using a `stat_*()` function, the `...`
    argument can be used to pass on parameters to the `geom` part of the
    layer. An example of this is
    `stat_density(geom = "area", outline.type = "both")`. The geom's
    documentation lists which parameters it can accept.

  - Inversely, when constructing a layer using a `geom_*()` function,
    the `...` argument can be used to pass on parameters to the `stat`
    part of the layer. An example of this is
    `geom_area(stat = "density", adjust = 0.5)`. The stat's
    documentation lists which parameters it can accept.

  - The `key_glyph` argument of
    [`layer()`](https://ggplot2.tidyverse.org/reference/layer.html) may
    also be passed on through `...`. This can be one of the functions
    described as [key
    glyphs](https://ggplot2.tidyverse.org/reference/draw_key.html), to
    change the display of the layer in the legend.

- times:

  A parameter used to control the number of values sampled from each
  distribution.

- alpha:

  ggplot2 alpha, i.e. transparency. It is included as a parameter to
  make sure the repeated draws are always visible

- seed:

  Set the seed for the layers random draw, allows you to plot the same
  draw across multiple layers.

- arrow:

  Arrow specification, as created by
  [`grid::arrow()`](https://rdrr.io/r/grid/arrow.html).

- arrow.fill:

  fill colour to use for the arrow head (if closed). `NULL` means use
  `colour` aesthetic.

- lineend:

  Line end style (round, butt, square).

- linejoin:

  Line join style (round, mitre, bevel).

- linemitre:

  Line mitre limit (number greater than 1).

- na.rm:

  If `FALSE`, the default, missing values are removed with a warning. If
  `TRUE`, missing values are silently removed.

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display. To include legend
  keys for all levels, even when no data exists, use `TRUE`. If `NA`,
  all levels are shown in legend, but unobserved levels are omitted.

- inherit.aes:

  If `FALSE`, overrides the default aesthetics, rather than combining
  with them. This is most useful for helper functions that define both
  data and aesthetics and shouldn't inherit behaviour from the default
  plot specification, e.g.
  [`annotation_borders()`](https://ggplot2.tidyverse.org/reference/annotation_borders.html).

- orientation:

  The orientation of the layer. The default (`NA`) automatically
  determines the orientation from the aesthetic mapping. In the rare
  event that this fails it can be given explicitly by setting
  `orientation` to either `"x"` or `"y"`. See the *Orientation* section
  for more detail.

- direction:

  direction of stairs: 'vh' for vertical then horizontal, 'hv' for
  horizontal then vertical, or 'mid' for step half-way between adjacent
  x-values.

## Value

A ggplot2 layer

## Examples

``` r
library(ggplot2)
library(dplyr)
library(distributional)

#ggplot
ggplot(economics, aes(date, unemploy)) + geom_line() 

#ggdibbler
ggplot(uncertain_economics, aes(date, unemploy)) + 
  geom_line_sample() 

  
# geom_step() is useful when you want to highlight exactly when
# the y value changes
recent <- economics[economics$date > as.Date("2013-01-01"), ]
uncertain_recent <- uncertain_economics[uncertain_economics$date > as.Date("2013-01-01"), ]
# geom line
ggplot(recent, aes(date, unemploy)) + geom_step()#ggplot

ggplot(uncertain_recent, aes(date, unemploy)) + geom_step_sample()#ggdibbler


# geom_path lets you explore how two variables are related over time,
# ggplot
m <- ggplot(economics, aes(unemploy, psavert))
m + geom_path(aes(colour = as.numeric(date)))

# ggdibbler
n <- ggplot(uncertain_economics, aes(unemploy, psavert))
n  + geom_path_sample(aes(colour = as.numeric(date)))


# You can use NAs to break the line.
df <- data.frame(x = 1:5, y = c(1, 2, NA, 4, 5))
uncertain_df <- df |> mutate(y=dist_normal(y, 0.3))
# ggplot
ggplot(df, aes(x, y)) + geom_point() + geom_line()
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_point()`).

# ggdibbler
ggplot(uncertain_df, aes(x, y)) + 
  geom_point_sample(seed=33) + 
  geom_line_sample(seed=33) 
#> Warning: NAs produced
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `dplyr::across(...)`.
#> Caused by warning in `stats::rnorm()`:
#> ! NAs produced
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `dplyr::across(...)`.
#> Caused by warning in `stats::rnorm()`:
#> ! NAs produced
#> Warning: Removed 10 rows containing missing values or values outside the scale range
#> (`geom_point()`).
```
