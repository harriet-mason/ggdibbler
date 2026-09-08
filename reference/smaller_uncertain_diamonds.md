# An uncertain (and shrunk down) version of the diamonds data from\`ggplot2\`

This dataset is a uncertain version of a subset of the diamonds data.
The subset of the diamonds data is stored as \`smaller_diamonds\`, while
the uncertain version of that data is \`smaller_uncertain_diamonds\`. We
only use a subset of the diamonds data as the \`ggdibbler\` approach can
take quite a long time when applied to the full sized diamonds data set.

## Usage

``` r
smaller_diamonds
```

## Format

A data frame with almost 1000 observations and 10 variables:

- price:

  Binomial random variable - price in US dollars (\$326–\$18,823)

- carat:

  Normal random variable - weight of the diamond (0.2–5.01)

- cut:

  Categorical random variable - quality of the cut (Fair, Good, Very
  Good, Premium, Ideal)

- color:

  Categorical random variable - diamond colour, from D (best) to J
  (worst)

- clarity:

  Categorical random variable - a measurement of how clear the diamond
  is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))

- x:

  Normal random variable - length in mm (0–10.74)

- y:

  Normal random variable - width in mm (0–58.9)

- z:

  Normal random variable - depth in mm (0–31.8)

- depth:

  Normal random variable - total depth percentage = z / mean(x, y) = 2
  \* z / (x + y) (43–79)

- table:

  Normal random variable - width of top of diamond relative to widest
  point (43–95)

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
1000 rows and 10 columns.
