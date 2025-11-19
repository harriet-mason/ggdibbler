# Violin plots with uncertainty

Identical to geom_violin, except that it will accept a distribution in
place of any of the usual aesthetics.

## Usage

``` r
geom_violin_sample(
  mapping = NULL,
  data = NULL,
  stat = "ydensity_sample",
  position = "identity",
  ...,
  times = 10,
  quantile_gp = list(linetype = 0),
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

stat_ydensity_sample(
  mapping = NULL,
  data = NULL,
  geom = "violin",
  position = "identity",
  ...,
  times = 10,
  width = NULL,
  bw = "nrd0",
  adjust = 1,
  kernel = "gaussian",
  trim = TRUE,
  scale = "area",
  drop = TRUE,
  bounds = c(-Inf, Inf),
  quantiles = c(0.25, 0.5, 0.75),
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
  [`geom_violin()`](https://ggplot2.tidyverse.org/reference/geom_violin.html)
  and
  [`stat_ydensity()`](https://ggplot2.tidyverse.org/reference/geom_violin.html).
  For more information about overriding these connections, see how the
  [stat](https://ggplot2.tidyverse.org/reference/layer_stats.html) and
  [geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
  arguments work.

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

- trim:

  If `TRUE` (default), trim the tails of the violins to the range of the
  data. If `FALSE`, don't trim the tails.

- scale:

  if "area" (default), all violins have the same area (before trimming
  the tails). If "count", areas are scaled proportionally to the number
  of observations. If "width", all violins have the same maximum width.

- drop:

  Whether to discard groups with less than 2 observations (`TRUE`,
  default) or keep such groups for position adjustment purposes
  (`FALSE`).

- bounds:

  Known lower and upper bounds for estimated data. Default
  `c(-Inf, Inf)` means that there are no (finite) bounds. If any bound
  is finite, boundary effect of default density estimation will be
  corrected by reflecting tails outside `bounds` around their closest
  edge. Data points outside of bounds are removed with a warning.

- quantiles:

  If not `NULL` (default), compute the `quantile` variable and draw
  horizontal lines at the given quantiles in
  [`geom_violin()`](https://ggplot2.tidyverse.org/reference/geom_violin.html).

## Examples

``` r
library(ggplot2)
library(dplyr)
library(distributional)

# have to make factor variable, probably easier ways to do it
uncertain_mtcars2 <- uncertain_mtcars |>
  rowwise() |> #must have this or the distributions get mixed up
  mutate(cyl_factor = dist_sample(list(factor(unlist(generate(cyl,100))))))

# plot set up
p <- ggplot(mtcars, aes(factor(cyl), mpg))
q <- ggplot(uncertain_mtcars2, aes(cyl_factor, mpg))

# ggplot
p + geom_violin()

# ggdibbler
q + geom_violin_sample(alpha=0.1)


# Orientation follows the discrete axis
# ggplot
ggplot(mtcars, aes(mpg, factor(cyl))) +
  geom_violin()

# ggdibbler
ggplot(uncertain_mtcars2, aes(mpg, cyl_factor)) +
  geom_violin_sample(alpha=0.1)


# ggplot
p + geom_violin() + 
  geom_jitter(height = 0, width = 0.1)

# ggdibbler
q + geom_violin_sample(alpha=0.1) + 
  geom_jitter_sample(height = 0, width = 0.1, size=0.1)


# Scale maximum width proportional to sample size:
# ggplot
p + geom_violin(scale = "count")

# ggdibbler
q + geom_violin_sample(scale = "count")


# Scale maximum width to 1 for all violins:
# ggplot
p + geom_violin(scale = "width")

# ggdibbler
q + geom_violin_sample(scale = "width", alpha=0.1)


# Default is to trim violins to the range of the data. To disable:
# ggplot
p + geom_violin(trim = FALSE)

# ggdibbler
q + geom_violin_sample(trim = FALSE, alpha=0.1)


# Use a smaller bandwidth for closer density fit (default is 1).
# ggplot
p + geom_violin(adjust = .5)

# ggdibbler
q + geom_violin_sample(adjust = .5, alpha=0.1)



# Add aesthetic mappings

# ggplot
ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_violin(aes(fill = cyl))

# ggdibbler
ggplot(uncertain_mtcars2, aes(cyl_factor, mpg)) + 
  geom_violin_sample(aes(fill = after_stat(x))) 


# ggplot
p + geom_violin(aes(fill = factor(cyl)))

# ggdibbler
q + geom_violin_sample(aes(fill = factor(after_stat(x))))


# Set aesthetics to fixed value
# ggplot
p + geom_violin(fill = "grey80", colour = "#3366FF")

# ggdibbler
q + geom_violin_sample(fill = "grey80", colour = "#3366FF", alpha=0.1)
```
