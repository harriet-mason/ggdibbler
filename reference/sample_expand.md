# Simulate outcomes from dibble to make a tibble

Simulates outcomes from all distributions in the dataset to make an
"expanded" data set that can be intepreted by ggplot2. This can be used
to debug ggdibbler plots, or used to make an uncertainty visualisation
for a geom that doesn't exist.

## Usage

``` r
sample_expand(data, times = 10)
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
#>  1 2      audi         a4          1.4  2001     4 auto… f        18    28 p    
#>  2 3      audi         a4          1.7  2001     4 auto… f        19    30 p    
#>  3 4      audi         passat      1.6  2000     4 auto… f        18    30 p    
#>  4 5      audi         f150 pic…   2.4  1998     4 auto… f        21    29 p    
#>  5 6      audi         a4          2.4  2000     4 auto… f        19    30 p    
#>  6 7      audi         a4          2.2  1998     4 auto… f        19    30 p    
#>  7 8      audi         civic       1.7  2000     4 auto… f        15    29 p    
#>  8 9      audi         c1500 su…   1.6  1998     4 manu… r        21    28 d    
#>  9 10     audi         a4          1.4  2000     4 auto… f        19    29 p    
#> 10 1      audi         dakota p…   2.3  2000     4 auto… f        19    30 p    
#> # ℹ 2,330 more rows
#> # ℹ 1 more variable: class <chr>
```
