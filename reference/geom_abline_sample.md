# Reference lines with uncertainty: horizontal, vertical, and diagonal

Identical to geom_vline, geom_hline and geom_abline, except that it will
accept a distribution in place of any of the usual aesthetics.

## Usage

``` r
geom_abline_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  times = 10,
  ...,
  slope,
  intercept,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = FALSE
)

geom_hline_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  position = "identity",
  ...,
  times = 10,
  yintercept,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = FALSE
)

geom_vline_sample(
  mapping = NULL,
  data = NULL,
  stat = "identity_sample",
  position = "identity",
  ...,
  times = 10,
  xintercept,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = FALSE
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html).

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

- xintercept, yintercept, slope, intercept:

  Parameters that control the position of the line. If these are set,
  `data`, `mapping` and `show.legend` are overridden.

## Examples

``` r
# load libraries
library(ggplot2)
library(distributional)

# ggplot
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
p + geom_abline() #' Can't see it - outside the range of the data

# ggdibbler
q <- ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample()
q + geom_abline_sample() #' Can't see it - outside the range of the data

# ggplot
p + geom_abline(intercept = 20)

# ggdibbler
q + geom_abline_sample(intercept = dist_normal(20, 1))


# Fixed values
# ggplot
p + geom_vline(xintercept = 5) #ggplot

q + geom_vline_sample(xintercept = dist_normal(5, 0.1)) 

p + geom_vline(xintercept = 1:5) #ggplot

q + geom_vline_sample(xintercept = dist_normal(1:5, 0.1)) #ggdibbler

p + geom_hline(yintercept = 20) #' ggplot

q + geom_hline_sample(yintercept = dist_normal(20, 1)) 


# Calculate slope and intercept of line of best fit
# get coef and standard error
summary(lm(mpg ~ wt, data = mtcars))
#> 
#> Call:
#> lm(formula = mpg ~ wt, data = mtcars)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -4.5432 -2.3647 -0.1252  1.4096  6.8727 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  37.2851     1.8776  19.858  < 2e-16 ***
#> wt           -5.3445     0.5591  -9.559 1.29e-10 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.046 on 30 degrees of freedom
#> Multiple R-squared:  0.7528, Adjusted R-squared:  0.7446 
#> F-statistic: 91.38 on 1 and 30 DF,  p-value: 1.294e-10
#> 
# ggplot for coef
p + geom_abline(intercept = 37, slope = -5)

# ggdibbler for coef AND standard error
p + geom_abline_sample(intercept = dist_normal(37, 1.8), slope = dist_normal(-5, 0.56),
                       times=30, alpha=0.1)
```
