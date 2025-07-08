
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggdibbler <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->

<!-- badges: end -->

`ggdibbler` is an R package for implementing signal suppression in
ggplot2. Usually, uncertainty visualisation focuses on expressing
uncertainty as a distribution or probability, whereas ggdibble
differentiates itself by viewing an uncertainty visualisation as a
transformation of an existing graphic that incorperates uncertainty. The
package allows you to replace any existing variable of observations in a
graphic, with a variable of distributons. It is particularly useful for
visualisations of estimates, such as a mean. You provide ggdibble with
code for an existing plot, but repalace one of the variables with a
distribution, and it will convert the visualisation into it’s signal
supression counterpart.

## Installation

You can install the development version of ggdibbler from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("harriet-mason/ggdibbler")
```

## Examples

Currently, the primary useage of ggdibbler is a variation on `geom_sf`,
by having several alternatives to the standard fill.

``` r
library(ggdibbler)
library(ggplot2)
library(dplyr)
library(sf)
```

Typically, if we had an average estimate for a series of areas, we would
simply display the average, or keep the average separate. Below is an
example of this with a choropleth map.

``` r
# Make average summary of data
toy_temp_mean <- toy_temp |> 
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(recorded_temp))

# plot it
ggplot(toy_temp_mean) +
  geom_sf(aes(geometry=county_geometry, fill=temp_mean)) +
  scale_fill_distiller(palette = "OrRd")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

We can use `geom_sf_sample` from the ggdibbler package to instead view
each estimate as a sample of values from its sampling distribution.

``` r
# sample map
toy_temp_dist |> 
  ggplot() + 
  geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist), linewidth=0.1) + 
  geom_sf(aes(geometry = county_geometry), fill=NA, linewidth=1) +
  scale_fill_distiller(palette = "OrRd")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

## Additions to the package

As `ggdibbler` is designed to alter existing graphic types to accept
distributions as inputs there is a near infinite number of plots that
could be changed with the package. At the moment the focus is on
alterations to `geom_sf`, but we are happy to add any other
functionality that users would like to have as a ggplot geom. If you
have a suggestion, feel free to add it in the github issues.
