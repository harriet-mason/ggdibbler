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
#'   \item{mpg}{Miles/(US) gallon as}
#'   \item{cyl}{}
#'   \item{disp}{}
#'   \item{hp}{}
#'   \item{drat}{}
#'   \item{wt}{}
#'   \item{qsec}{}
#'   \item{vs}{}
#'   \item{am}{}
#'   \item{gear}{}
#'   \item{carb}{}
#' }
#' @name uncertain_mtcars
NULL
