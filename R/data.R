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