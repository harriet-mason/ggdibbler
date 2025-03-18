
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggdibbler

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
#> Warning: package 'ggplot2' was built under R version 4.3.1
#> 
#> Attaching package: 'ggplot2'
#> The following object is masked from 'package:ggdibbler':
#> 
#>     scale_type
```

Typically, if we had an average estimate for a series of areas, we would
simply display the average, or keep the average separate. Below is an
example of this with a choropleth map.

``` r
# normal map
toymap |> 
  ggplot() + 
  geom_sf(aes(geometry = geometry, fill=temp)) +
  scale_fill_viridis_c()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

We can use `geom_sf_sample` from the ggdibbler package to instead view
each estimate as a sample of values from its sampling distribution.

``` r
# sample map
toymap |> 
  ggplot() + 
  geom_sf_sample(aes(geometry = geometry, fill=temp_dist), linewidth=0.1) + 
  geom_sf(aes(geometry=geometry), fill=NA, linewidth=1) +
  scale_fill_viridis_c()
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
