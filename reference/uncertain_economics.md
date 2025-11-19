# An uncertain version of the economics data from\`ggplot2\`

This dataset is identical to the economics data, except that every
variable in the data set is represented by a normal random variable. The
original \`economics\` dataset is based on real US economic time series
data, but the uncertainty we added is hypothetical and included for
illustrative purposes.

## Usage

``` r
uncertain_economics_long
```

## Format

A data frame with almost 574 observations and 6 variables:

- date:

  A deterministic variable - Month of data collection

- pce:

  Normal random variable - personal consumption expenditures, in
  billions of dollars

- pop:

  Normal random variable - total population, in thousands

- psavert:

  Normal random variable - personal savings rate

- uempmed:

  Normal random variable - median duration of unemployment, in weeks

- unemploy:

  Normal random variable - number of unemployed in thousands

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
2870 rows and 4 columns.
