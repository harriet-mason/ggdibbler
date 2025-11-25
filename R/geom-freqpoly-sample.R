#' @export
#' @inheritParams geom_histogram_sample
#' @importFrom ggplot2 make_constructor GeomPath
#' @rdname geom_histogram_sample
geom_freqpoly_sample <- function(mapping = NULL, data = NULL,
                          stat = "bin_sample", position = "identity",
                          ...,
                          na.rm = FALSE, times=10,
                          seed = NULL,
                          show.legend = NA,
                          inherit.aes = TRUE) {
  
  params <- list2(na.rm = na.rm, times=times, seed = seed, ...)
  if (identical(stat, "bin_sample")) {
    params$pad <- TRUE
  }
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomPath,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = params
  )
}
