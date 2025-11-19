# An uncertain (and shrunk down) version of the diamonds data from\`ggplot2\`

This dataset is a subset of the diamonds data. There is a deterministic
version that is only a subset (smaller_diamonds) and a version that has
random variables (uncertain_smaller_diamonds). The data is only a subset
as the ggdibbler approach can take quite a long time when applied to the
full sized diamonds data set. An uncertain version of the original
diamonds data is also available as uncertain_diamonds, although it isn't
used in any examples.

## Usage

``` r
smaller_diamonds

uncertain_diamonds
```

## Format

A data frame with almost 54000 observations and 10 variables:

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

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
5000 rows and 20 columns.
