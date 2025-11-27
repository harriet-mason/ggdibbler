#' Uncertain Rug plots in the margins
#' 
#' Identical to geom_rug, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_rug
#' @importFrom ggplot2 make_constructor GeomRug
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' 
#' # ggplot
#' p <- ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point()
#' # ggdibbler
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg)) +
#'   geom_point_sample(seed=4)
#' 
#' p + geom_rug() #ggplot
#' q + geom_rug_sample(seed=4) #ggdibbler
#' @export
geom_rug_sample <- make_constructor(GeomRug, stat = "identity_sample", 
                                    times=10, alpha = 1/log(times), seed = NULL)