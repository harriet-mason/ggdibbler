#' A toy data set that provides data for a map with the temperature of each area represented by a random variable.
#'
#' The map shows a wave pattern in temperature on the state of Iowa.
#' Each estimate also has an uncertainty component added, and is represented as a distribution
#'
#' @format A tibble with 99 observations and 4 variables
#' \describe{
#'   \item{county_name}{the name of each Iowa county}
#'   \item{temp_dist}{the temperature of each county as a distribution}
#'   \item{county_geometry}{the shape file for each county of Iowa}
#' }
#'
#' @docType data
#' @name toy_temp_dist
NULL

#' A toy data set that has the ambient temperature as measured by a collection of citizen scientists for each Iowa county
#'
#' There are several measurements for each county, with no location marker
#'  for individual scientists to preserve anonyminity. Counties can have 
#'  different numbers of observations as well as a different levels of variance
#'  between the observations in the county.
#'
#' @format A tibble with 99 observations and 4 variables
#' \describe{
#'   \item{county_name}{the name of each Iowa county}
#'   \item{recorded_temp}{the ambient temperature recorded by the citizen scientist}
#'   \item{scientistID}{the ID number for the scientist who made the recording}
#'   \item{county_geometry}{the shape file for each county of Iowa}
#'   \item{county_longitude}{the centroid longitude for each county of Iowa}
#'   \item{county_latitude}{the centroid latitude for each county of Iowa}
#' }
#'
#' @docType data
#' @name toy_temp
NULL

#' An uncertain version of the MPG data from `ggplot2`
#' 
#' This dataset is based on the Fuel economy data from 1999 to 2008 from `ggplot2`, 
#' but every value is represented by a distribution. Every variable in the data set
#' is represetned by a categorical, discrete, or continuous random variable. The
#' original MPG dataset in ggplot is a real a subset of the fuel economy data from 
#' the EPA, but the uncertainty is hypothetical uncertainty for each data type, added
#' by us for illustrative purposes.
#'
#' @format A data frame with 234 rows and 11 variables:
#' \describe{
#'   \item{manufacturer}{manufacturer, as a categorical random variable}
#'   \item{model}{model name as a categorical random variable}
#'   \item{displ}{engine displacement, as a uniform random variable to represent bounded data}
#'   \item{year}{year of manufacture, as a sample of possible years}
#'   \item{cyl}{number of cylinders, as a categorical random variable}
#'   \item{trans}{type of transmission, as a categorical random variable}
#'   \item{drv}{the type of drive train, as a categorical random variable }
#'   \item{cty}{city miles per gallon, as a discrete random variable}
#'   \item{hwy}{highway miles per gallon, as a discrete random variable}
#'   \item{fl}{fuel type, as a categorical random variable}
#'   \item{class}{"type" of car, as a categorical random variable}
#' }
#' @docType data
#' @name uncertain_mpg
NULL

#' An uncertain version of the mtcars data from base R `datasets` 
#' 
#' This dataset is identical to the mtcars data, except that every  variable in the data set
#' is represented by a categorical, discrete, or continuous random variable. The
#' original `mtcars` dataset in datasets is based on real data extracted from the 1974 Motor Trend US
#' magazine, but the uncertainty we added is hypothetical and included for illustrative purposes.
#'
#' @format A data frame with 32 observations and 11 variables:
#' \describe{
#'   \item{mpg}{Uniform random variable - Miles/(US) gallon as}
#'   \item{cyl}{Categorical random variable - Number of cylinders}
#'   \item{disp}{Uniform random variable - Displacement (cu.in.)}
#'   \item{hp}{Normal random variable - Gross horsepower}
#'   \item{drat}{Uniform random variable - Rear axle ratio}
#'   \item{wt}{Uniform random variable - Weight (1000 lbs)}
#'   \item{qsec}{Uniform random variable - 1/4 mile time}
#'   \item{vs}{Bernouli random variable - Engine (0 = V-shaped, 1 = straight)}
#'   \item{am}{Bernouli random variable - Transmission (0 = automatic, 1 = manual)}
#'   \item{gear}{Categorical random variable - Number of forward gears}
#'   \item{carb}{Categorical random variable- Number of carburetors}
#' }
#' @name uncertain_mtcars
NULL

#' An uncertain (and shrunk down) version of the diamonds data from`ggplot2` 
#' 
#' This dataset is a subset of the diamonds data. There is a deterministic version that is only 
#' a subset (smaller_diamonds) and a version that has random variables (uncertain_smaller_diamonds). 
#' The data is only a subset as the ggdibbler approach can take quite a long time when applied to
#' the full sized diamonds data set. An uncertain version of the original diamonds data is also
#' available as uncertain_diamonds, although it isn't used in any examples.
#'
#' @format A data frame with almost 54000 observations and 10 variables:
#' \describe{
#'   \item{price}{Binomial random variable - price in US dollars ($326–$18,823)}
#'   \item{carat}{Normal random variable - weight of the diamond (0.2–5.01)}
#'   \item{cut}{Categorical random variable - quality of the cut (Fair, Good, Very Good, Premium, Ideal)}
#'   \item{color}{Categorical random variable - diamond colour, from D (best) to J (worst)}
#'   \item{clarity}{Categorical random variable - a measurement of how clear the diamond is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))}
#'   \item{x}{Normal random variable - length in mm (0–10.74)}
#'   \item{y}{Normal random variable - width in mm (0–58.9)}
#'   \item{z}{Normal random variable - depth in mm (0–31.8)}
#'   \item{depth}{Normal random variable - total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)}
#'   \item{table}{Normal random variable - width of top of diamond relative to widest point (43–95)}
#' }
#' @name smaller_uncertain_diamonds
NULL

#' @rdname smaller_uncertain_diamonds
"smaller_diamonds"

#' @rdname smaller_uncertain_diamonds
"uncertain_diamonds"

#' An uncertain version of the economics data from`ggplot2`
#' 
#' This dataset is identical to the economics data, except that every  
#' variable in the data set is represented by a normal
#' random variable. The original `economics` dataset is based on real 
#' US economic time series data, but the uncertainty we added is hypothetical 
#' and included for illustrative purposes.
#'
#' @format A data frame with almost 574 observations and 6 variables:
#' \describe{
#'   \item{date}{A deterministic variable - Month of data collection}
#'   \item{pce}{Normal random variable - personal consumption expenditures, in billions of dollars}
#'   \item{pop}{Normal random variable - total population, in thousands}
#'   \item{psavert}{Normal random variable - personal savings rate}
#'   \item{uempmed}{Normal random variable - median duration of unemployment, in weeks}
#'   \item{unemploy}{Normal random variable - number of unemployed in thousands}
#'   }
#' @name uncertain_economics
NULL

#' @rdname uncertain_economics
"uncertain_economics_long"

#' 2d density estimate of Old Faithful data with uncertainty
#'
#' A 2d density estimate of the waiting and eruptions variables data
#' \link{faithful}. Unlike other uncertain datasets, the only uncertain variable is
#' density. Since this is based on a model, it wouldn't make sense for erruptions or
#' waiting to be represented as random variables.
#'
#' @format A data frame with 5,625 observations and 3 variables:
#' \describe{
#'   \item{eruptions}{Eruption time in mins}
#'   \item{waiting}{Waiting time to next eruption in mins}
#'   \item{density0}{A 2d density estimate that is normally distributed with a low variance}
#'   \item{density}{A 2d density estimate that is normally distributed with a medium variance}
#'   \item{density2}{A 2d density estimate that is normally distributed with a high variance}
#' }
#' @name uncertain_faithfuld
NULL

#' Step Counts from Walktober 2025 Challenge
#'
#' Daily step counts during October 2025 for five teams of four people 
#' competing in the Walktober 2025 Challenge.
#'
#' @format A data frame with 744 observations and 4 variables:
#' \describe{
#'   \item{team}{Team name}
#'   \item{name}{Name of team member}
#'   \item{date}{Date steps were recorded}
#'   \item{steps}{Number of steps recorded on `date`}
#' }
#' @name walktober
NULL

#' Old Faithful data with uncertainty
#'
#' The old faithful data from the datasets package but with added 
#' uncertainty.
#'
#' @format A data frame:
#' \describe{
#'   \item{eruptions}{Eruption time in mins}
#'   \item{waiting}{Waiting time to next eruption in mins}
#' }
#' @name uncertain_faithful
NULL


