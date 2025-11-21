# Any combination of nested positions

This function lets you nest any two positions available in ggplot2 (your
results may vary). This allows you to set different position adjustments
for the "main" and "distribution" parts of your plot.

## Usage

``` r
position_nest(position = "identity_identity")
```

## Examples

``` r
# nested positions allows us to differentiate which postion adjustments
# are used for the plot groups vs the distribution samples
library(ggplot2)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), alpha=0.9,
                  position = position_nest("stack_dodge"))
```
