#' Uncertain Smooth
#' 
#' Identical to geom_smooth, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_smooth
#' @importFrom ggplot2 GeomSmooth aes layer
#' @importFrom rlang list2
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth()
#' 
#' # ggdibbbler
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2) + 
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1) 
#' # Note: each line will have its own estimated error bands. This uncertainty
#' # should still be shown, as it is different to the resampled uncertainty
#' # displayed by ggdibbler.
#' 
#' 
#' # If you need the fitting to be done along the y-axis set the orientation
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth(orientation = "y")
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, orientation = "y")+
#'   scale_y_continuous_distribution(limits=c(12,46)) +
#'   scale_x_continuous_distribution(limits=c(1,7))
#' 
#' # Use span to control the "wiggliness" of the default loess smoother.
#' # The span is the fraction of points used to fit each local regression:
#' # small numbers make a wigglier curve, larger numbers make a smoother curve.
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth(span = 0.3)
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, span = 0.3)+
#'   scale_y_continuous_distribution(limits=c(12,46)) +
#'   scale_x_continuous_distribution(limits=c(1,7))
#' 
#' # Instead of a loess smooth, you can use any other modelling function:
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth(method = lm, se = FALSE)
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, method = lm, se = FALSE)+
#'   scale_y_continuous_distribution(limits=c(12,46)) +
#'   scale_x_continuous_distribution(limits=c(1,7))
#' 
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE)
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1,
#'                      method = lm, formula = y ~ splines::bs(x, 3), se = FALSE)+
#'   scale_y_continuous_distribution(limits=c(12,46)) +
#'   scale_x_continuous_distribution(limits=c(1,7))
#' 
#' 
#' # Smooths are automatically fit to each group (defined by categorical
#' # aesthetics or the group aesthetic) and for each facet.
#' # ggplot
#' ggplot(mpg, aes(displ, hwy, colour = class)) +
#'   geom_point() +
#'   geom_smooth(se = FALSE, method = lm)
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(displ, hwy, colour = class)) +
#'   geom_point_sample(alpha=0.5, size=0.2) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, se = FALSE, method = lm) +
#'   scale_y_continuous_distribution(limits=c(12,46)) +
#'   scale_x_continuous_distribution(limits=c(1,7))
#' 
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth(span = 0.8) +
#'   facet_wrap(~drv)
#' # ggdibbler (facets cannot be random, complain to posit, I can't control this)
#' uncertain_mpg$drv2 <- mpg$drv
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, span = 0.8) +
#'   facet_wrap(~drv2)
#'   
#' @export
geom_smooth_sample <- function(mapping = NULL, data = NULL,
                        stat = "smooth_sample", position = "identity",
                        ...,
                        times = 10,
                        method = NULL,
                        formula = NULL,
                        se = TRUE,
                        na.rm = FALSE,
                        orientation = NA,
                        show.legend = NA,
                        inherit.aes = TRUE) {
  
  params <- rlang::list2(
    times = times,
    na.rm = na.rm,
    orientation = orientation,
    se = se,
    ...
  )
  if (identical(stat, "smooth_sample")) {
    params[["method"]] <- method
    params$formula <- formula
  }
  
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomSmooth,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = params
  )
}