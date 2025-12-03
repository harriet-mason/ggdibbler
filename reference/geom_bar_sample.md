# Uncertain Bar Charts

Identical to geom_bar, except that it will accept a distribution in
place of any of the usual aesthetics.

## Usage

``` r
geom_bar_sample(
  mapping = NULL,
  data = NULL,
  stat = "count_sample",
  position = "stack_dodge",
  ...,
  just = 0.5,
  times = 10,
  seed = NULL,
  lineend = "butt",
  linejoin = "mitre",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

geom_col_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  position = "stack_dodge",
  ...,
  just = 0.5,
  times = 10,
  seed = NULL,
  lineend = "butt",
  linejoin = "mitre",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

stat_count_sample(
  mapping = NULL,
  data = NULL,
  geom = "bar",
  position = "stack_identity",
  ...,
  orientation = NA,
  times = 10,
  alpha = 1/log(times),
  seed = NULL,
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

- just:

  Adjustment for column placement. Set to `0.5` by default, meaning that
  columns will be centered about axis breaks. Set to `0` or `1` to place
  columns to the left/right of axis breaks. Note that this argument may
  have unintended behaviour when used with alternative positions, e.g.
  [`position_dodge()`](https://ggplot2.tidyverse.org/reference/position_dodge.html).

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

  Override the default connection between
  [`geom_bar()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)
  and
  [`stat_count()`](https://ggplot2.tidyverse.org/reference/geom_bar.html).
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

- alpha:

  ggplot2 alpha, i.e. transparency. It is included as a parameter to set
  the default value to 1/log(times) to make sure the repeated draws are
  always visible

## Value

A ggplot2 layer

## Examples

``` r
library(distributional)
library(ggplot2)

# Set up data
g <- ggplot(mpg, aes(class)) #ggplot
q <- ggplot(uncertain_mpg, aes(class)) #ggdibbler

# Number of cars in each class:
g + geom_bar() #ggplot

q + geom_bar_sample() #ggdibbler - a

q + geom_bar_sample(position = "identity_dodge", alpha=1) #ggdibbler - b


# make dataframe
df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
uncertain_df <-  data.frame(trt = c("a", "b", "c"), 
                            outcome = dist_normal(mean = c(2.3, 1.9, 3.2), 
                                                  sd = c(0.5, 0.8, 0.7)))
# geom_col also has a sample counterpart
# ggplot
ggplot(df, aes(trt, outcome)) + geom_col()

# ggdibbler
ggplot(uncertain_df, aes(x=trt, y=outcome)) + geom_col_sample()


# ggplot
ggplot(mpg, aes(y = class)) +
  geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE)) +
  theme(legend.position = "top")

# ggdibbler
ggplot(uncertain_mpg, aes(y = class)) +
  geom_bar_sample(aes(fill = drv), alpha=1,
                  position = position_stack_dodge(reverse = TRUE)) +
  theme(legend.position = "top")
```
