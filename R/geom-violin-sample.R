#' Violin plots with uncertainty
#' 
#' Identical to geom_violin, except that it will accept a distribution in
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_violin
#' @inheritParams ggplot2::stat_ydensity
#' @importFrom ggplot2 layer GeomViolin
#' @importFrom rlang list2 current_call caller_env
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @returns A ggplot2 layer
#' 
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' 
#' # plot set up
#' p <- ggplot(mtcars, 
#'   aes(factor(cyl), mpg))
#' q <- ggplot(uncertain_mtcars, 
#'   aes(dist_transformed(cyl, factor, as.numeric), mpg))
#' 
#' # ggplot
#' p + geom_violin()
#' # ggdibbler
#' q + geom_violin_sample(alpha=0.1)
#'
#' # Default is to trim violins to the range of the data. To disable:
#' # ggplot
#' p + geom_violin(trim = FALSE)
#' # ggdibbler
#' q + geom_violin_sample(trim = FALSE, alpha=0.1)
#' 
#' @export
geom_violin_sample <- function(mapping = NULL, data = NULL, times = 10, seed = NULL,
                        stat = "ydensity_sample", position = "dodge_identity",
                        ...,
                        trim = TRUE,
                        bounds = c(-Inf, Inf),
                        quantile.colour = NULL,
                        quantile.color = NULL,
                        quantile.linetype = 0L,
                        quantile.linewidth = NULL,
                        draw_quantiles = deprecated(),
                        scale = "area",
                        na.rm = FALSE,
                        orientation = NA,
                        show.legend = NA,
                        inherit.aes = TRUE) {
  
  extra <- list()
  if (lifecycle::is_present(draw_quantiles)) {
    
    extra$quantiles <- draw_quantiles
    
    # Turn on quantile lines
    if (!is.null(quantile.linetype)) {
      quantile.linetype <- max(quantile.linetype, 1)
    }
  }
  
  quantile_gp <- list(
    colour    = quantile.color %||% quantile.colour,
    linetype  = quantile.linetype,
    linewidth = quantile.linewidth
  )

  
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomViolin,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      times = times,
      seed = seed,
      trim = trim,
      scale = scale,
      na.rm = na.rm,
      orientation = orientation,
      bounds = bounds,
      quantile_gp = quantile_gp,
      !!!extra,
      ...
    )
  )
}

