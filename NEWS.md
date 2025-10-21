# ggdibbler (development version)

# Version v0.2.0

## New Featues
### Functions
- `geom_point_sample` and `stat_sample`
  - an alternative version of `geom_point` that allows a distribution to be passed to any aesthetic
- `scale_x_distribution` and `scale_y_distribution`
  - scale functions that allow distributions to be passed to the position axis

## Changes
- The `n` variable in `geom_sf_sample` has changed to the `times` 
  - This avoids confusion as `n` is used by some `ggplot2` functions as a parameter.
  - `times` actually represents the sample size, while `n` was the dimension of the grid (so the actual sample used was $n^2$)
  - The most square factors of `times` will be used to generate the subdivided grid

# Version v0.1.0

Initial CRAN submission.

## New features
### Functions

- `geom_sf_sample()`: Visualise an sf object with random variable for fill

### Data sets

- `toy_temp`: A toy data set that has the ambient temperature as measured by a hypothetical citizen scientists in Iowa
- `toy_temp_dist`: A toy data set of Iowa with an example average temperature for each county
