#' Uncertain Bar Charts
#' 
#' Identical to geom_bar, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_bar
#' @importFrom ggplot2 make_constructor GeomBar
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(distributional)
#' library(ggplot2)
#' 
#' g <- ggplot(mpg, aes(class)) #ggplot
#' q <- ggplot(uncertain_mpg, aes(class)) #ggdibbler
#' 
#' # Number of cars in each class:
#' g + geom_bar() #ggplot
#' q + geom_bar_sample() #ggdibbler
#' 
#' # Total engine displacement of each class
#' g + geom_bar(aes(weight = displ)) #ggplot
#' q + geom_bar_sample(aes(weight = displ)) #ggdibbler
#' 
#' # Map class to y instead to flip the orientation
#' ggplot(mpg) + geom_bar(aes(y = class)) #ggplot
#' ggplot(uncertain_mpg) + geom_bar_sample(aes(y = class)) #ggdibbler
#' 
#' # geom_col also has a sample counterpart
#' df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
#' uncertain_df <-  data.frame(trt = c("a", "b", "c"), 
#'                             outcome = dist_normal(mean = c(2.3, 1.9, 3.2), sd = c(0.5, 0.8, 0.7)))
#' # ggplot
#' ggplot(df, aes(trt, outcome)) +
#'   geom_col()
#' # ggdibbler
#' ggplot(uncertain_df, aes(x=trt, y=outcome)) +
#'   geom_col_sample(alpha=0.05, position = "identity", times=30)
#' ggplot(uncertain_df, aes(x=trt, y=outcome)) +
#'   geom_col_sample(times = 30)
#' @export
geom_bar_sample <- make_constructor(ggplot2::GeomBar, stat = "count_sample", position="dodge",
                                    just = 0.5, times=10)