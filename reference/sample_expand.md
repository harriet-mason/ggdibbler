# Simulate outcomes from dibble to make a tibble

Simulates outcomes from all distributions in the dataset to make an
"expanded" data set that can be intepreted by ggplot2. This can be used
to debug ggdibbler plots, or used to make an uncertainty visualisation
for a geom that doesn't exist. If (and only if) you are implementing a
ggdibbler version of a ggplot stat extension, you should use
dibble_to_tibble instead.

## Usage

``` r
sample_expand(data, times = 10, seed = NULL)

dibble_to_tibble(data, params)
```

## Arguments

- data:

  Distribution dataset to expand into samples

- times:

  A parameter used to control the number of values sampled from each
  distribution.

- seed:

  Set the seed for the layers random draw, allows you to get the same
  draw from repeated sample_expand calls

- params:

  the params argument for the stat function sample_expand(uncertain_mpg,
  times=10)

## Value

A data frame of resampled values from the input distributions
