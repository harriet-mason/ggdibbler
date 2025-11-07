#' Uncertain Text
#' 
#' Identical to geom_text, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @importFrom ggplot2 make_constructor GeomText
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_text
#' @param times A parameter used to control the number of values sampled from each distribution. 
#' 
#' @examples
#' library(ggplot2)
#' 
#' p <- ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars)))
#' p + geom_text() # ggplot example
#' 
#' # note: categories are determnistic as they are row names
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg, label = rownames(uncertain_mtcars)))
#' q + geom_text_sample(times=10) #ggdibbler
#' 
#' # Avoid overlaps
#' p + geom_text(check_overlap = TRUE) #ggplot
#' q + geom_text_sample(check_overlap = TRUE) #ggdibbler
#' 
#' # Labels with background
#' p + geom_label() #ggplot
#' q + geom_label_sample(times=10) #ggdibbler
#' 
#' # Change size of the label
#' p + geom_text(size = 10) #ggplot
#' q + geom_text_sample(size = 10) #ggdibbler
#' 
#' # Set aesthetics to fixed value
#' p +
#'   geom_point() +
#'   geom_text(hjust = 0, nudge_x = 0.05) #ggplot
#' q +
#'   geom_point_sample() +
#'   geom_text_sample(hjust = 0, nudge_x = 0.05, times=1) #ggplot
#' @export
geom_text_sample <- make_constructor(GeomText, position = "nudge", stat = "identity_sample", times=10)




