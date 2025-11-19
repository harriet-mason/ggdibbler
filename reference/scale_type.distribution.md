# Sets scale for distributions

Generates a single value from the distribution and uses it to set the
default ggplot scale. The scale can be changed later in the ggplot by
using any scale\_\* function

## Usage

``` r
# S3 method for class 'distribution'
scale_type(x)
```

## Arguments

- x:

  value being scaled

## Value

A character vector of scale types. The scale type is the ggplot scale
type of the outcome of the distribution.
