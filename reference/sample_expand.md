# Simulate outcomes from dibble to make a tibble

Simulates outcomes from all distributions in the dataset to make an
"expanded" data set that can be intepreted by ggplot2. This can be used
to debug ggdibbler plots, or used to make an uncertainty visualisation
for a geom that doesn't exist.

## Usage

``` r
sample_expand(data, times = 10, seed = NULL)
```

## Arguments

- data:

  Distribution dataset to expand into samples

- times:

  A parameter used to control the number of values sampled from each
  distribution.

- seed:

  Set the seed for the layers random draw, allows you to get the same
  draw from repeated sample_expand calls sample_expand(uncertain_mpg,
  times=10)

## Value

A data frame of resampled values from the input distributions
