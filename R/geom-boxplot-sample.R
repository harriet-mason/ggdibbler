#' An uncertain box and whiskers plot (in the style of Tukey)
#' 
#' Identical to geom_boxplot, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_boxplot
#' @inheritParams ggplot2::stat_boxplot
#' @importFrom ggplot2 GeomSmooth aes layer
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' # ggplot
#' p <- ggplot(mpg, aes(class, hwy))
#' p + geom_boxplot(alpha=0.5)
#' 
#' # using alpha to manage overplotting
#' q <- ggplot(uncertain_mpg, aes(class, hwy)) 
#' q + geom_boxplot_sample(alpha=0.1) 
#' 
#' # ggplot
#' p + geom_boxplot(varwidth = TRUE)
#' # ggdibbler
#' q + geom_boxplot_sample(alpha=0.1, varwidth = TRUE) 
#' 
#' # ggplot
#' p + geom_boxplot(aes(colour = drv), position = position_dodge(preserve = "single"))
#' # ggdibbler
#' q + geom_boxplot_sample(aes(colour = drv), alpha=0.05, position = "dodge_identity")
#' 
#' @export
geom_boxplot_sample <- make_constructor(ggplot2::GeomBoxplot, stat = "boxplot_sample",
                                        times=10, seed = NULL)

