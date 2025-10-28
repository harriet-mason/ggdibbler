# ggdibbler 0.3.0

# Version v0.3.0

## New Featues
### Functions
These functions are all heavily in development, and I cannot (and do not) guarantee their usability beyond the use cases presented in the example code. 
There are still some kinks to work out with the grouping solution. 
You are welcome to use them, but I would stick to the example cases for the next few weeks (don't go crazy with any random fill or group aesthetics is all I will say).
New additions to stats and geoms include:

- `geom_bar_sample`, `geom_col_sample` and `stat_count_sample`
- `geom_count_sample` and `stat_sum_sample`
- `geom_jitter_sample`
- `geom_density_sample` and `stat_density_sample`
- `geom_text_sample` and `geom_label_sample`
- `geom_polygon_sample`
- `geom_rug_sample`
- `geom_path_sample`, `geom_line_sample`, and `geom_step_sample`

We also have the addition of a discrete position distribution scale:

- `scale_x_discrete_distribution` & `scale_y_discrete_distribution`

### Data sets
As we go through and replicate the `ggplot2` examples, we have been adding random versions of the `ggplot2` data sets. 
This will make it clear to the users how the package works, and highlight that the uncertainty visualisation is a 
function of an existing graphic.

- `smaller_diamonds` is a subset of  `ggplot2::diamonds`
- `smaller_uncertain_diamonds` is a random variable version of  `smaller_diamonds`
- `uncertain_mpg` is a random variable version of `ggplot2::mpg`
- `uncertain_mtcars` is a random variable
- `uncertain_economics` and `uncertain_economics_longer` are random variable version of `ggplot2::economics`

## Changes
- We changed `scale_*_distribution` to `scale_*_continuous_distribution`
    - This is because we have included `scale_*_discrete_distribution`  to allow plotting of discrete random variables

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
