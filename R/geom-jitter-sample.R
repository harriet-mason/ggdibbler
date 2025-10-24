#' Uncertain Jittered Points
#' 
#' Identical to geom_jitter, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_jitter 
#' @importFrom ggplot2 make_constructor GeomPoint position_jitter layer
#' @importFrom rlang list2
#' @importFrom cli cli_abort
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
#' @examples
#' library(ggplot2)
#' 
#' # ggplot
#' p <- ggplot(mpg, aes(cyl, hwy)) #ggplot
#' p + geom_point()
#' p + geom_jitter()
#' 
#' # ggdibbler
#' q <- ggplot(uncertain_mpg, aes(cyl, hwy)) #ggdibbler
#' q + geom_point_sample(times=10) 
#' q + geom_jitter_sample(times=10)
#' 
#' # Add aesthetic mappings
#' p + geom_jitter(aes(colour = class)) #ggplot
#' p + geom_jitter_sample(aes(colour = class)) #ggdibler
#' 
#' # Use smaller width/height to emphasise categories
#' p + geom_jitter(width = 0.2) # ggplot
#' q + geom_jitter_sample(width = 0.2, times=10) # ggdibbler
#' @export
geom_jitter_sample <- function(mapping = NULL, data = NULL, stat = "sample", position = "jitter",
                        ..., width = NULL, height = NULL, na.rm = FALSE, times=30,
                        show.legend = NA, inherit.aes = TRUE) {
  if (!missing(width) || !missing(height)) {
    if (!missing(position)) {
      cli_abort(c(
        "Both {.arg position} and {.arg width}/{.arg height} were supplied.",
        "i" = "Choose a single approach to alter the position."
      ))
    }
    
    position <- position_jitter(width = width, height = height)
  }
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomPoint,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      na.rm = na.rm,
      times = times,
      ...
    )
  )
}
