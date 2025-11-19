# 2d density estimate of Old Faithful data with uncertainty

A 2d density estimate of the waiting and eruptions variables data
[faithful](https://rdrr.io/r/datasets/faithful.html). Unlike other
uncertain datasets, the only uncertain variable is density. Since this
is based on a model, it wouldn't make sense for erruptions or waiting to
be represented as random variables.

## Format

A data frame with 5,625 observations and 3 variables:

- eruptions:

  Eruption time in mins

- waiting:

  Waiting time to next eruption in mins

- density:

  A 2d density estimate that is normally distributed with a low variance

- density2:

  A 2d density estimate that is normally distributed with a high
  variance
