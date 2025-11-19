# Simulate outcomes from dibble to make a tibble

Simulates outcomes from all distributions in the dataset to make an
"expanded" data set that can be intepreted by ggplot2. This can be used
to debug ggdibbler plots, or used to make an uncertainty visualisation
for a geom that doesn't exist.

## Usage

``` r
sample_expand(data, times)
```

## Arguments

- data:

  Distribution dataset to expand into samples

- times:

  The number of values sampled from each distribution in the data set.

## Examples

``` r
sample_expand(uncertain_mpg, times=10)
#> # A tibble: 2,340 × 12
#>    drawID manufacturer model     displ  year   cyl trans drv     cty   hwy fl   
#>    <fct>  <chr>        <chr>     <dbl> <int> <int> <chr> <chr> <int> <int> <chr>
#>  1 2      audi         4runner …   1.5  2000     4 auto… f        19    30 p    
#>  2 3      audi         a4          2.1  1998     4 auto… f        18    30 p    
#>  3 4      audi         new beet…   1.2  1998     4 auto… f        20    30 p    
#>  4 5      audi         a4          1.6  2000     4 auto… r        18    30 p    
#>  5 6      audi         a4          1.5  1998     4 auto… f        20    30 p    
#>  6 7      audi         caravan …   1.8  2000     4 auto… f        20    30 p    
#>  7 8      audi         jetta       2.2  2000     4 auto… f        20    28 c    
#>  8 9      audi         a6 quatt…   1.3  2000     4 auto… 4        18    29 p    
#>  9 10     audi         c1500 su…   1.4  1998     4 auto… f        19    30 p    
#> 10 1      ford         a4          1.8  2000     4 auto… f        20    29 p    
#> # ℹ 2,330 more rows
#> # ℹ 1 more variable: class <chr>
```
