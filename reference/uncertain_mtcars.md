# An uncertain version of the mtcars data from base R \`datasets\`

This dataset is identical to the mtcars data, except that every variable
in the data set is represented by a categorical, discrete, or continuous
random variable. The original \`mtcars\` dataset in datasets is based on
real data extracted from the 1974 Motor Trend US magazine, but the
uncertainty we added is hypothetical and included for illustrative
purposes.

## Format

A data frame with 32 observations and 11 variables:

- mpg:

  Uniform random variable - Miles/(US) gallon as

- cyl:

  Categorical random variable - Number of cylinders

- disp:

  Uniform random variable - Displacement (cu.in.)

- hp:

  Normal random variable - Gross horsepower

- drat:

  Uniform random variable - Rear axle ratio

- wt:

  Uniform random variable - Weight (1000 lbs)

- qsec:

  Uniform random variable - 1/4 mile time

- vs:

  Bernouli random variable - Engine (0 = V-shaped, 1 = straight)

- am:

  Bernouli random variable - Transmission (0 = automatic, 1 = manual)

- gear:

  Categorical random variable - Number of forward gears

- carb:

  Categorical random variable- Number of carburetors
