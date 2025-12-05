# Visualise densities with Uncertainty

Identical to geom_density, except that the fill for each density will be
represented by a sample from each distribution.

## Usage

``` r
geom_density_sample(
  mapping = NULL,
  data = NULL,
  stat = "density_sample",
  position = "identity",
  ...,
  outline.type = "upper",
  seed = NULL,
  times = 10,
  lineend = "butt",
  linejoin = "round",
  linemitre = 10,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

stat_density_sample(
  mapping = NULL,
  data = NULL,
  geom = "area",
  position = "stack_identity",
  ...,
  orientation = NA,
  seed = NULL,
  times = 10,
  bw = "nrd0",
  adjust = 1,
  kernel = "gaussian",
  n = 512,
  trim = FALSE,
  bounds = c(-Inf, Inf),
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

- outline.type:

  Type of the outline of the area; `"both"` draws both the upper and
  lower lines, `"upper"`/`"lower"` draws the respective lines only.
  `"full"` draws a closed polygon around the area.

- seed:

  Set the seed for the layers random draw, allows you to plot the same
  draw across multiple layers.

- times:

  A parameter used to control the number of values sampled from each
  distribution.

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

- geom, stat:

  Use to override the default connection between
  [`geom_density()`](https://ggplot2.tidyverse.org/reference/geom_density.html)
  and
  [`stat_density()`](https://ggplot2.tidyverse.org/reference/geom_density.html).
  For more information about overriding these connections, see how the
  [stat](https://ggplot2.tidyverse.org/reference/layer_stats.html) and
  [geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
  arguments work.

- orientation:

  The orientation of the layer. The default (`NA`) automatically
  determines the orientation from the aesthetic mapping. In the rare
  event that this fails it can be given explicitly by setting
  `orientation` to either `"x"` or `"y"`. See the *Orientation* section
  for more detail.

- bw:

  The smoothing bandwidth to be used. If numeric, the standard deviation
  of the smoothing kernel. If character, a rule to choose the bandwidth,
  as listed in
  [`stats::bw.nrd()`](https://rdrr.io/r/stats/bandwidth.html). Note that
  automatic calculation of the bandwidth does not take weights into
  account.

- adjust:

  A multiplicate bandwidth adjustment. This makes it possible to adjust
  the bandwidth while still using the a bandwidth estimator. For
  example, `adjust = 1/2` means use half of the default bandwidth.

- kernel:

  Kernel. See list of available kernels in
  [`density()`](https://rdrr.io/r/stats/density.html).

- n:

  number of equally spaced points at which the density is to be
  estimated, should be a power of two, see
  [`density()`](https://rdrr.io/r/stats/density.html) for details

- trim:

  If `FALSE`, the default, each density is computed on the full range of
  the data. If `TRUE`, each density is computed over the range of that
  group: this typically means the estimated x values will not line-up,
  and hence you won't be able to stack density values. This parameter
  only matters if you are displaying multiple densities in one plot or
  if you are manually adjusting the scale limits.

- bounds:

  Known lower and upper bounds for estimated data. Default
  `c(-Inf, Inf)` means that there are no (finite) bounds. If any bound
  is finite, boundary effect of default density estimation will be
  corrected by reflecting tails outside `bounds` around their closest
  edge. Data points outside of bounds are removed with a warning.

## Value

A ggplot2 layer

## Examples

``` r
library(ggplot2)

# Basic density plot
# GGPLOT
ggplot(smaller_diamonds, aes(carat)) + 
  geom_density()

# GGDIBBLER
ggplot(smaller_uncertain_diamonds, aes(carat)) + 
  geom_density_sample(alpha=0.5)


# ggplot
ggplot(smaller_diamonds, aes(depth, fill = cut, colour = cut)) +
  geom_density(alpha = 0.7) +
  xlim(55, 70)

# ggdibbler
ggplot(smaller_uncertain_diamonds, aes(depth, fill = cut)) +
  geom_density_sample(aes(colour = after_stat(fill)), alpha = 0.1) +
  scale_x_continuous_distribution(limits=c(55, 70)) + #' ggdibbler does not have an xlim (yet)
  theme(palette.colour.discrete = "viridis",
        palette.fill.discrete = "viridis") #' bug: random variables have different colour


  
```
