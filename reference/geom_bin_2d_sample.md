# Uncertain heatmap of 2d bin counts

Identical to geom_bin_2d, except that it will accept a distribution in
place of any of the usual aesthetics.

## Usage

``` r
geom_bin_2d_sample(
  mapping = NULL,
  data = NULL,
  stat = "bin2d_sample",
  position = "identity_dodge",
  ...,
  times = 10,
  seed = NULL,
  lineend = "butt",
  linejoin = "mitre",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

stat_bin_2d_sample(
  mapping = NULL,
  data = NULL,
  geom = "tile",
  position = "identity_dodge",
  ...,
  times = 10,
  seed = NULL,
  binwidth = NULL,
  bins = 30,
  breaks = NULL,
  drop = TRUE,
  boundary = NULL,
  closed = NULL,
  center = NULL,
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

- seed:

  Set the seed for the layers random draw, allows you to plot the same
  draw across multiple layers.

- lineend:

  Line end style (round, butt, square).

- linejoin:

  Line join style (round, mitre, bevel).

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

- geom, stat:

  Use to override the default connection between
  [`geom_bin_2d()`](https://ggplot2.tidyverse.org/reference/geom_bin_2d.html)
  and
  [`stat_bin_2d()`](https://ggplot2.tidyverse.org/reference/geom_bin_2d.html).
  For more information about overriding these connections, see how the
  [stat](https://ggplot2.tidyverse.org/reference/layer_stats.html) and
  [geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
  arguments work.

- binwidth:

  The width of the bins. Can be specified as a numeric value or as a
  function that takes x after scale transformation as input and returns
  a single numeric value. When specifying a function along with a
  grouping structure, the function will be called once per group. The
  default is to use the number of bins in `bins`, covering the range of
  the data. You should always override this value, exploring multiple
  widths to find the best to illustrate the stories in your data.

  The bin width of a date variable is the number of days in each time;
  the bin width of a time variable is the number of seconds.

- bins:

  Number of bins. Overridden by `binwidth`. Defaults to 30.

- breaks:

  Alternatively, you can supply a numeric vector giving the bin
  boundaries. Overrides `binwidth`, `bins`, `center`, and `boundary`.
  Can also be a function that takes group-wise values as input and
  returns bin boundaries.

- drop:

  if `TRUE` removes all cells with 0 counts.

- closed:

  One of `"right"` or `"left"` indicating whether right or left edges of
  bins are included in the bin.

- center, boundary:

  bin position specifiers. Only one, `center` or `boundary`, may be
  specified for a single plot. `center` specifies the center of one of
  the bins. `boundary` specifies the boundary between two bins. Note
  that if either is above or below the range of the data, things will be
  shifted by the appropriate integer multiple of `binwidth`. For
  example, to center on integers use `binwidth = 1` and `center = 0`,
  even if `0` is outside the range of the data. Alternatively, this same
  alignment can be specified with `binwidth = 1` and `boundary = 0.5`,
  even if `0.5` is outside the range of the data.

## Value

A ggplot2 layer

## Examples

``` r
# ggplot
library(ggplot2)
d <- ggplot(smaller_diamonds, aes(x, y)) 
d + geom_bin_2d()
#> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.

# ggdibbler
b <- ggplot(smaller_uncertain_diamonds, aes(x, y)) 
# the ggdibbler default position adjustment is dodging
b + geom_bin_2d_sample(times=100)
#> `stat_bin2d_sample()` using `bins = 30`. Pick better value `binwidth`.

# but it can change it to be transparency
b + geom_bin_2d_sample(position="identity", alpha=0.1)
#> `stat_bin2d_sample()` using `bins = 30`. Pick better value `binwidth`.

# Still have the same options
d + geom_bin_2d(bins = 10) #ggplot

b + geom_bin_2d_sample(bins = 10) #ggdibbler
```
