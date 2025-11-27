#' Uncertain Text
#' 
#' Identical to geom_text and geom_label except that it will accept a 
#' distribution in place of any of the usual aesthetics.
#' 
#' @importFrom ggplot2 make_constructor GeomText
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_text
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' 
#' @examples
#' library(ggplot2)
#' 
#' p <- ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars)))
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg, label = rownames(uncertain_mtcars)))
#' 
#' # Text example
#' p + geom_text() # ggplot 
#' q + geom_text_sample(times=3) #ggdibbler

#' # Labels with background
#' p + geom_label() #ggplot
#' q + geom_label_sample(times=3) #ggdibbler
#' 
#' # Random text with constant position (harder to read signal supression)
#' # ggplot
#' ggplot(mtcars, aes(wt, mpg, label = cyl)) +
#'  geom_text(size=6)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(mean(wt), mean(mpg), lab = cyl)) +
#'  geom_text_sample(aes(label = after_stat(lab)), size=6)
#' 
#' @export
geom_text_sample <- make_constructor(GeomText, position = "nudge", stat = "identity_sample", 
                                     times=10, alpha = 1/log(times), seed = NULL)




