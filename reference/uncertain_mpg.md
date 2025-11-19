# An uncertain version of the MPG data from \`ggplot2\`

This dataset is based on the Fuel economy data from 1999 to 2008 from
\`ggplot2\`, but every value is represented by a distribution. Every
variable in the data set is represetned by a categorical, discrete, or
continuous random variable. The original MPG dataset in ggplot is a real
a subset of the fuel economy data from the EPA, but the uncertainty is
hypothetical uncertainty for each data type, added by us for
illustrative purposes.

## Format

A data frame with 234 rows and 11 variables:

- manufacturer:

  manufacturer, as a categorical random variable

- model:

  model name as a categorical random variable

- displ:

  engine displacement, as a uniform random variable to represent bounded
  data

- year:

  year of manufacture, as a sample of possible years

- cyl:

  number of cylinders, as a categorical random variable

- trans:

  type of transmission, as a categorical random variable

- drv:

  the type of drive train, as a categorical random variable

- cty:

  city miles per gallon, as a discrete random variable

- hwy:

  highway miles per gallon, as a discrete random variable

- fl:

  fuel type, as a categorical random variable

- class:

  "type" of car, as a categorical random variable
