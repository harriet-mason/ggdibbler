#' Uncertain heatmap of 2d bin counts
#' 
#' Identical to geom_bin_2d, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_bin_2d
#' @importFrom ggplot2 make_constructor GeomBin2d
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' print("replace me")
#' @export
geom_bin_2d_sample <- make_constructor(ggplot2::GeomBin2d, stat = "bin2d_sample", 
                                       times=10, position="identity_dodge")
