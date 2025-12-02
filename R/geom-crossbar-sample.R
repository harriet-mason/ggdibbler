#' @importFrom ggplot2 GeomCrossbar make_constructor
#' @importFrom rlang list2
#' @rdname geom_linerange_sample
#' @export
geom_crossbar_sample <- function(mapping = NULL, data = NULL, times=10, seed = NULL,
                          stat = "identity_sample", position = "identity",
                          ...,
                          middle.colour     = NULL,
                          middle.color      = NULL,
                          middle.linetype   = NULL,
                          middle.linewidth  = NULL,
                          box.colour        = NULL,
                          box.color         = NULL,
                          box.linetype      = NULL,
                          box.linewidth     = NULL,
                          fatten = deprecated(),
                          na.rm = FALSE,
                          orientation = NA,
                          show.legend = NA,
                          inherit.aes = TRUE) {

  middle_gp <- list(
    colour    = middle.color %||% middle.colour,
    linetype  = middle.linetype,
    linewidth = middle.linewidth
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
    geom = ggplot2::GeomCrossbar,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      times = times,
      seed = seed,
      middle_gp = middle_gp,
      box_gp = box_gp,
      fatten = fatten,
      na.rm = na.rm,
      orientation = orientation,
      ...
    )
  )
}

