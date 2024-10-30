#' A toy data set that gives an example of a map with random variables as temperature estimates
#'
#' The map shows a wave pattern in temperature on the state of Iowa.
#' Each estimate also has an uncertainty component added, either as a
#' distribution, or as a sample from the sampling distribution.
#'
#' @format A tibble with 99 observations and 4 variables
#' \describe{
#'   \item{county_name}{the name of each Iowa county}
#'   \item{temp_dist}{the temperature of each county as a distribution}
#'   \item{temp_sample}{the temperature of each county as a sample}
#'   \item{geometry}{the shape file of Iowa and it's counties}
#' }
#'
#' @docType data
#' @name toymap
NULL