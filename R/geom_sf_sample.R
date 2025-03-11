#' @export
geom_sf_sample <- function(mapping = aes(), data = NULL, stat = "sample",
                           position = "identity", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, n = NULL, ...) {
  c(
    layer_sf(
      geom = GeomSf,
      data = data,
      mapping = mapping,
      stat = stat,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = rlang::list2(
        na.rm = na.rm,
        n = n,
        ...
      )
    ),
    coord_sf(default = TRUE)
  )
}

#' @export
scale_type.distribution <- function(x) {
  "continuous"
}
