# Uncertain Smooth

Identical to geom_smooth, except that it will accept a distribution in
place of any of the usual aesthetics.

## Usage

``` r
geom_smooth_sample(
  mapping = NULL,
  data = NULL,
  times = 10,
  seed = NULL,
  stat = "smooth_sample",
  position = "identity",
  ...,
  method = NULL,
  formula = NULL,
  se = TRUE,
  na.rm = FALSE,
  orientation = NA,
  show.legend = NA,
  inherit.aes = TRUE
)

stat_smooth_sample(
  mapping = NULL,
  data = NULL,
  geom = "smooth",
  position = "identity",
  ...,
  times = 10,
  seed = NULL,
  method = NULL,
  formula = NULL,
  se = TRUE,
  n = 80,
  span = 0.75,
  fullrange = FALSE,
  xseq = NULL,
  level = 0.95,
  method.args = list(),
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

- times:

  A parameter used to control the number of values sampled from each
  distribution.

- seed:

  Set the seed for the layers random draw, allows you to plot the same
  draw across multiple layers.

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

- method:

  Smoothing method (function) to use, accepts either `NULL` or a
  character vector, e.g. `"lm"`, `"glm"`, `"gam"`, `"loess"` or a
  function, e.g. [`MASS::rlm`](https://rdrr.io/pkg/MASS/man/rlm.html) or
  [`mgcv::gam`](https://rdrr.io/pkg/mgcv/man/gam.html),
  [`stats::lm`](https://rdrr.io/r/stats/lm.html), or
  [`stats::loess`](https://rdrr.io/r/stats/loess.html). `"auto"` is also
  accepted for backwards compatibility. It is equivalent to `NULL`.

  For `method = NULL` the smoothing method is chosen based on the size
  of the largest group (across all panels).
  [`stats::loess()`](https://rdrr.io/r/stats/loess.html) is used for
  less than 1,000 observations; otherwise
  [`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html) is used with
  `formula = y ~ s(x, bs = "cs")` with `method = "REML"`. Somewhat
  anecdotally, `loess` gives a better appearance, but is \\O(N^{2})\\ in
  memory, so does not work for larger datasets.

  If you have fewer than 1,000 observations but want to use the same
  `gam()` model that `method = NULL` would use, then set
  `method = "gam", formula = y ~ s(x, bs = "cs")`.

- formula:

  Formula to use in smoothing function, eg. `y ~ x`, `y ~ poly(x, 2)`,
  `y ~ log(x)`. `NULL` by default, in which case `method = NULL` implies
  `formula = y ~ x` when there are fewer than 1,000 observations and
  `formula = y ~ s(x, bs = "cs")` otherwise.

- se:

  Display confidence band around smooth? (`TRUE` by default, see `level`
  to control.)

- na.rm:

  If `FALSE`, the default, missing values are removed with a warning. If
  `TRUE`, missing values are silently removed.

- orientation:

  The orientation of the layer. The default (`NA`) automatically
  determines the orientation from the aesthetic mapping. In the rare
  event that this fails it can be given explicitly by setting
  `orientation` to either `"x"` or `"y"`. See the *Orientation* section
  for more detail.

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
  [`geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)
  and
  [`stat_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html).
  For more information about overriding these connections, see how the
  [stat](https://ggplot2.tidyverse.org/reference/layer_stats.html) and
  [geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
  arguments work.

- n:

  Number of points at which to evaluate smoother.

- span:

  Controls the amount of smoothing for the default loess smoother.
  Smaller numbers produce wigglier lines, larger numbers produce
  smoother lines. Only used with loess, i.e. when `method = "loess"`, or
  when `method = NULL` (the default) and there are fewer than 1,000
  observations.

- fullrange:

  If `TRUE`, the smoothing line gets expanded to the range of the plot,
  potentially beyond the data. This does not extend the line into any
  additional padding created by `expansion`.

- xseq:

  A numeric vector of values at which the smoother is evaluated. When
  `NULL` (default), `xseq` is internally evaluated as a sequence of `n`
  equally spaced points for continuous data.

- level:

  Level of confidence band to use (0.95 by default).

- method.args:

  List of additional arguments passed on to the modelling function
  defined by `method`.

## Value

A ggplot2 layer

## Examples

``` r
library(ggplot2)
# ggplot
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'


# ggdibbbler
ggplot(uncertain_mpg, aes(displ, hwy)) +
  geom_point_sample(alpha=0.5, size=0.2, seed = 22) + 
  geom_smooth_sample(linewidth=0.2, alpha=0.1, seed = 22) 
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'


# Smooths are automatically fit to each group (defined by categorical
# aesthetics or the group aesthetic) and for each facet.
# ggplot
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  geom_smooth(se = FALSE, method = lm)
#> `geom_smooth()` using formula = 'y ~ x'

# ggdibbler
ggplot(uncertain_mpg, aes(displ, hwy, colour = class)) +
  geom_point_sample(alpha=0.5, size=0.2, seed = 22) +
  geom_smooth_sample(linewidth=0.2, alpha=0.1, 
    se = FALSE, method = lm, seed = 22)
#> `geom_smooth()` using formula = 'y ~ x'

```
