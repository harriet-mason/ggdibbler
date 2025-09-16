
# code that generates warning
p2 <- ggplot2::ggplot() + 
  stat_sample(data = test_data, ggplot2::aes(x=bob, y=john))

x <- c(1, 2, 3, "a")

warning = function(w) {
  if (!grepl(pattern, w$message)) {
    warnings_list <<- c(warnings_list, list(w))
  }
}

withCallingHandlers({x_numeric <- as.numeric(x)})
warnings_list <- list()
result <- withCallingHandlers(
  {
    x <- c(1, 2, 3, "a")
    x_numeric <- as.numeric(x)
  },
  
  invokeRestart("muffleWarning")
  }
)
for (w in warnings_list) {
  warning(w)
}
return(result)

# ggplot warning kidnap
capture_and_filter_warnings <- function(expr, pattern) {
  warnings_list <- list()
  result <- withCallingHandlers(
    expr,
    warning = function(w) {
      if (!grepl(pattern, w$message)) {
        warnings_list <<- c(warnings_list, list(w))
      }
      invokeRestart("muffleWarning")
    }
  )
  for (w in warnings_list) {
    warning(w)
  }
  return(result)
}

# Example usage:
capture_and_filter_warnings(
  {
    x <- c(1, 2, 3, "a")
    x_numeric <- as.numeric(x) # This warning will be suppressed
    print(x_numeric)
    
    a <- c(1, 2, 3, 4, 5)
    b <- c(6, 7, 8, 9)
    print(a + b) # This warning will still appear
  },
  pattern = "dist"
)

# try for xdist and ydist issue

capture_and_filter_warnings(
  {
    p2 <- ggplot2::ggplot() + 
      stat_sample(data = test_data, ggplot2::aes(x=bob, y=john))
  },
  pattern = "dist"
)

capture_and_filter_warnings(
  {
    #code goes here
  },
  pattern = "dist"
)
