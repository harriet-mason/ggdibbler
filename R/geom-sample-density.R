#' @export
GeomSampleDensity <- ggproto(
  "GeomSampleDensity", ggplot2::GeomDensity,
  default_aes = aes(
    colour = from_theme(colour %||% ink),
    fill   = from_theme(fill %||% NA),
    weight = 1,
    alpha  = NA,
    linewidth = from_theme(linewidth),
    linetype  = from_theme(linetype)
  )
)#' Smoothed density estimates
#'
#' Computes and draws kernel density estimate, which is a smoothed version of
#' the histogram. This is a useful alternative to the histogram for continuous
#' data that comes from an underlying smooth distribution.
#' @export
geom_sample_density <- ggplot2::make_constructor(
  GeomSampleDensity, 
  stat = "sample_density", 
  outline.type = "upper",
  checks = rlang::exprs(
    outline.type <- rlang::arg_match0(outline.type, c("both", "upper", "lower", "full"))
  )
)
