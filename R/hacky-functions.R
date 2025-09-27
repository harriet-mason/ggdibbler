#' Swaps all distributions passed to aes to *dist naming
#' @param mapping some argument passed through a ggplot2::aes()
#' @param data data passed into ggplot2 layer
#' @noRd
#' @keywords internal
mappingswap <- function(mapping, data){
  distcols <- names(data)[sapply(data, distributional::is_distribution)]
  distindex <- as.character(sapply(mapping, rlang::quo_get_expr)) %in% distcols
  new_mapping <- mapping
  names(new_mapping)[distindex] <-  paste(names(new_mapping),"dist", sep="")[distindex]
  new_mapping
}


#' Filters/edits warnings from ggplot2 layer
#' @param expr code block we are filtering warnings for
#' @noRd
#' @keywords internal
capture_and_filter_warnings <- function(expr) {
  # Make listholder for legitimate warnings
  warnings_list_qYJRGU1dIM1tAP <<- list()
  # Filter warnings that match the internal ggplot warning
  result <- withCallingHandlers(
    expr,
    warning = warning_func
  )
  
  # Give warning for actual legit warnings
  for (w in warnings_list_qYJRGU1dIM1tAP) {
    warning(w)
  }
  # Remove warning list from global environment
  # rm(warnings_list_qYJRGU1dIM1tAP, envir = globalenv())
  return(result)
}


# set up function that filters warnings
warning_func <- function(w) {
  # Set false flas as warning I am trying to filter
  false_flag <- ".*Ignoring unknown aesthetics:.*"
  
  # Add warnings that are not related to false flag
  if (!grepl(false_flag, w$message)) {
    warnings_list_qYJRGU1dIM1tAP <<- c(warnings_list_qYJRGU1dIM1tAP, list(w))
  }
  
  # Add warnings with other variables in it
  if (grepl(false_flag, w$message)){
    # Get rid of formatting characters
    a <- "\\\033\\[[0-9;]*m"
    check <- strsplit(w$message, a)[[1]]
    # Get list of variables that are throwing the warning
    fine <- c("Ignoring unknown aesthetics: ", "", ", and ", ", ", " and ")
    vars <- check[which(!(check %in% fine))]
    # remove dist suffix to get actual variable names
    vars <- gsub("dist", "", vars)
    # Check if any variable names are actually not allowed
    fineaes <- c("x", "y",	"alpha",	"colour",	"fill",	"group", "shape", "size", "stroke")
    if(!all(vars %in% fineaes)){
      # get correct variables
      bad_vars <- vars[which(!(vars %in% fineaes))]
      # remake warning message
      bad_vars <- paste0("\033[32m", bad_vars, "\033[38;5;239m")
      # change grammar if more than one bad variable
      n <- length(bad_vars)
      if(n>1){
        bad_vars <- c(bad_vars[-((n-1):n)], paste0(bad_vars[n-1], " and ", bad_vars[n]))
      }
      # update warning message
      w$message <- paste0("\033[38;5;239mIgnoring unknown aesthetics: ",
                          paste(bad_vars, collapse = ", "),
                          "\033[39m")
      warnings_list_qYJRGU1dIM1tAP <<- c(warnings_list_qYJRGU1dIM1tAP, list(w))
    }
  }
  invokeRestart("muffleWarning")
}



