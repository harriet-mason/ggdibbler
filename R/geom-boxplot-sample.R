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
geom_boxplot_sample <- function(mapping = NULL, data = NULL, times=10, seed = NULL,
                         stat = "boxplot_sample", position = "identity",
                         ...,
                         outliers = TRUE,
                         outlier.colour = NULL,
                         outlier.color = NULL,
                         outlier.fill = NULL,
                         outlier.shape = NULL,
                         outlier.size = NULL,
                         outlier.stroke = 0.5,
                         outlier.alpha = NULL,
                         whisker.colour    = NULL,
                         whisker.color     = NULL,
                         whisker.linetype  = NULL,
                         whisker.linewidth = NULL,
                         staple.colour     = NULL,
                         staple.color      = NULL,
                         staple.linetype   = NULL,
                         staple.linewidth  = NULL,
                         median.colour     = NULL,
                         median.color      = NULL,
                         median.linetype   = NULL,
                         median.linewidth  = NULL,
                         box.colour        = NULL,
                         box.color         = NULL,
                         box.linetype      = NULL,
                         box.linewidth     = NULL,
                         notch = FALSE,
                         notchwidth = 0.5,
                         staplewidth = 0,
                         varwidth = FALSE,
                         na.rm = FALSE,
                         orientation = NA,
                         show.legend = NA,
                         inherit.aes = TRUE) {

  
  
  outlier_gp <- list(
    colour = outlier.color %||% outlier.colour,
    fill   = outlier.fill,
    shape  = outlier.shape,
    size   = outlier.size,
    stroke = outlier.stroke,
    alpha  = outlier.alpha
  )
  
  whisker_gp <- list(
    colour    = whisker.color %||% whisker.colour,
    linetype  = whisker.linetype,
    linewidth = whisker.linewidth
  )
  
  staple_gp <- list(
    colour    = staple.color %||% staple.colour,
    linetype  = staple.linetype,
    linewidth = staple.linewidth
  )
  
  median_gp <- list(
    colour    = median.color %||% median.colour,
    linetype  = median.linetype,
    linewidth = median.linewidth
  )
  
  box_gp <- list(
    colour    = box.color %||% box.colour,
    linetype  = box.linetype,
    linewidth = box.linewidth
  )
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomBoxplot,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      seed = seed,
      times = times, 
      outliers = outliers,
      outlier_gp = outlier_gp,
      whisker_gp = whisker_gp,
      staple_gp  = staple_gp,
      median_gp  = median_gp,
      box_gp     = box_gp,
      notch = notch,
      notchwidth = notchwidth,
      staplewidth = staplewidth,
      varwidth = varwidth,
      na.rm = na.rm,
      orientation = orientation,
      ...
    )
  )
}
