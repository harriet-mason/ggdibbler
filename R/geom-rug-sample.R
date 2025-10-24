#' Uncertain Rug plots in the margins
#' 
#' Identical to geom_rug, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_rug
#' @importFrom ggplot2 make_constructor GeomRug
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' 
#' # ggplot
#' p <- ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point()
#' p
#' # ggdibbler
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg)) +
#'   geom_point_sample(size=0.7)
#' q
#' 
#' p + geom_rug() #ggplot
#' q + geom_rug_sample() #ggdibbler
#' 
#' # Rug on bottom only
#' p + geom_rug(sides="b") #ggplot
#' q + geom_rug_sample(sides="b") #ggdibbler
#' 
#' # All four sides
#' p + geom_rug(sides="trbl") #ggplot
#' q + geom_rug_sample(sides="trbl") #ggdibbler
#' @export
geom_rug_sample <- make_constructor(GeomRug, stat = "sample", times=10)