#' Uncertain Columns
#' 
#' Alternative version of geom_col that accepts random variables as input.
#' 
#' @inheritParams ggplot2::geom_col
#' @importFrom ggplot2 make_constructor GeomCol
#' @param times A parameter used to control the number of times we sample from each distribution.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' set.seed(911000)
#' df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
#' uncertain_df <-  data.frame(trt = c("a", "b", "c"), 
#'                             outcome = dist_normal(mean = c(2.3, 1.9, 3.2), sd = c(0.5, 0.8, 0.7)))
#' # ggplot
#' ggplot(df, aes(trt, outcome)) +
#'   geom_col()
#' # ggdibbler
#' ggplot(uncertain_df, aes(x=trt, y=outcome)) +
#'   geom_col_sample(alpha=0.05, times=30)
#' # can also get a similar effect with position dodge?
#' ggplot(uncertain_df, aes(x=trt, y=outcome)) +
#'   geom_col_sample(times = 30, position = "dodge")
#' @export
geom_col_sample <- make_constructor(GeomCol, stat = "sample",  
                                    # position = "stack", was removed (might be bad)
                                    just = 0.5, times = 10
                                    )