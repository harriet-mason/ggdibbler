#' Visualise Uncertain Points
#' 
#' Identical to geom_point, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
#' @importFrom ggplot2 aes layer GeomPoint
#' @importFrom rlang list2
#' @importFrom dplyr rename_with
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_point
#' @examples
#' library(ggplot2)
#' 
#'   # ggplot
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + geom_point()
#' 
#'   # ggdibbler
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg))
#' q + geom_point_sample()
#' 
#' # Add aesthetic mappings
#' 
#'  # ggplot
#' p + geom_point(aes(colour = factor(cyl)))
#'   # ggdibbler - a
#' q + geom_point_sample(aes(colour = cyl))
#'   # ggdibbler - b
#'   # If you want the categorical colour for a factor,
#'   # You would need to have a categorical rand variable 
#'   # If you dont, you can always just compute the colour with after_stat()
#' ggplot(data = uncertain_mtcars, aes(x=wt, y=mpg, distcol=cyl)) + 
#'   geom_point_sample(aes(colour = factor(after_stat(distcol))))
#'   
#'  # ggplot
#' p + geom_point(aes(shape = factor(cyl))) 
#'   # ggdibbler - a
#' q + geom_point_sample(aes(shape = cyl)) + scale_shape_binned()
#'   # ggdibbler - b
#' ggplot(data = uncertain_mtcars, aes(x=wt, y=mpg, distshape=cyl)) +
#'   geom_point_sample(aes(shape = factor(after_stat(distshape))))
#'  
#' # A "bubblechart":
#' # ggplot2
#' p + geom_point(aes(size = qsec))
#' # ggdibbler
#' q + geom_point_sample(aes(size = qsec), alpha=0.5, times=5)
#' 
#' Set aesthetics to fixed value
#' # ggplot
#' ggplot(mtcars, aes(wt, mpg)) + geom_point(colour = "red", size = 3)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample(colour = "red", size = 3)
#' @export
geom_point_sample <- make_constructor(GeomPoint, stat = "sample", times=30)



