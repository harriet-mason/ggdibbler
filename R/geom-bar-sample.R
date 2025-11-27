#' Uncertain Bar Charts
#' 
#' Identical to geom_bar, except that it will accept a distribution in place of 
#' any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_bar
#' @importFrom ggplot2 make_constructor GeomBar
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(distributional)
#' library(ggplot2)
#' 
#' # Set up data
#' g <- ggplot(mpg, aes(class)) #ggplot
#' q <- ggplot(uncertain_mpg, aes(class)) #ggdibbler
#' 
#' # Number of cars in each class:
#' g + geom_bar() #ggplot
#' q + geom_bar_sample() #ggdibbler - a
#' q + geom_bar_sample(position = "identity_dodge", alpha=1) #ggdibbler - b
#' 
#' # geom_col also has a sample counterpart
#' # ggplot
#' ggplot(df, aes(trt, outcome)) + geom_col()
#' # ggdibbler
#' ggplot(uncertain_df, aes(x=trt, y=outcome)) + geom_col_sample()
#' 
#' # make dataframe
#' df <- data.frame(trt = c("a", "b", "c"), outcome = c(2.3, 1.9, 3.2))
#' uncertain_df <-  data.frame(trt = c("a", "b", "c"), 
#'                             outcome = dist_normal(mean = c(2.3, 1.9, 3.2), 
#'                                                   sd = c(0.5, 0.8, 0.7)))
#' # ggplot
#' ggplot(mpg, aes(y = class)) +
#'   geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE)) +
#'   theme(legend.position = "top")
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(y = class)) +
#'   geom_bar_sample(aes(fill = drv), alpha=1,
#'                   position = position_stack_dodge(reverse = TRUE)) +
#'   theme(legend.position = "top")
#' @export
geom_bar_sample <- make_constructor(ggplot2::GeomBar, stat = "count_sample", 
                                    position="stack_dodge", just = 0.5, 
                                    times=10, seed = NULL)