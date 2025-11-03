#' Simulate outcomes from dibble to make a tibble
#' 
#' Simulates outcomes from all distributions in the dataset to make an "expanded" data
#' set that can be intepreted by ggplot2. This can be used to debug ggdibbler plots, or
#' used to make an uncertainty visualisation for a geom that doesn't exist.
#' 
#' @importFrom dplyr mutate across all_of
#' @importFrom distributional generate is_distribution family
#' @importFrom tibble rowid_to_column
#' @importFrom tidyr unnest_longer
#' @param data Distribution dataset to expand into samples
#' @param times The number of values sampled from each distribution in the data set.
#' @examples
#' sample_expand(uncertain_mpg, times=10)
#' @export
sample_expand <- function(data, times){ 
  
  # Check for at least one distribution vector
  distcols <- get_dist_cols(data)
  if(length(distcols)==0) return(data |> dplyr::mutate(drawID=0))
  
  # get deterministic variables
  othcols <- setdiff(names(data), distcols)
  
  # Sample from distribution variables
  data |>
    # get sample and convert to tidy format
    dplyr::mutate(dplyr::across(dplyr::all_of(distcols), ~ distributional::generate(.x, times = times))) |>
    tidyr::unnest_longer(dplyr::all_of(distcols)) |>
    # get drawID for grouping later
    tibble::rowid_to_column(var = "drawID") |>
    dplyr::mutate(drawID = as.factor(drawID%%times + 1))
}

#' @keywords internal
# Internal function that fixes the grouping and interacts it with drawID
adjust_grouping <- function(data, discretedists){
  # convert all variables into factors
  data <- data |>
    # make sure all discrete distributions are factors (and)
    dplyr::mutate(dplyr::across(dplyr::all_of(discretedists), as.factor),
                  group = as.factor(group)) 
  print("in grouping 1")
  print(table(data$group))
  # get list of variables to interact & edit group
  intvars <- c("group", discretedists, "drawID")
  data$group <- as.numeric(interaction(data[,intvars]))
  print("in grouping 2")
  print(discretedists)
  print(table(data$group))
  # convert to data frame for weight warning
  as.data.frame(data)
  }


#' @keywords internal
get_dist_cols <- function(data){
  names(data)[sapply(data, distributional::is_distribution)]
}

#' @keywords internal
get_discrete_cols <- function(data){
  a <- names(data)[sapply(data, is_discrete)]
  b <- names(data)[sapply(data, ggplot2:::is_mapped_discrete)]
  c(a,b)
}

#' @keywords internal
# Internal function that edits data inside stat
dibble_to_tibble <- function(data, params) {
  print(as_tibble(data))
  # return data if deterministic
  distcols <- get_dist_cols(data)
  if(length(distcols)==0) return(data|> dplyr::mutate(drawID=0))
  
  # expand data
  data <- sample_expand(data, params$times) 
  
  # check for discrete distribution columns for group adjust
  discretecols <- get_discrete_cols(data)
  
  # check for transformed discrete
  
  
  discretedists <- discretecols[which(get_discrete_cols(data)  %in% distcols)]
  print(distcols)
  print(discretecols)
  if(length(discretedists)==0) discretedists = NULL
  
  # If discrete distribution, then fix grouping
  adjust_grouping(data, discretedists)
}

