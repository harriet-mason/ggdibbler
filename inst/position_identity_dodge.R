#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
#' @export
position_identity_dodge <- function(width = NULL, preserve = "total", orientation = "x",
                           reverse = FALSE) {
  check_bool(reverse)
  ggproto(PositionIdentityDodge, PositionDodge,
          width = width,
          preserve = arg_match0(preserve, c("total", "single")),
          orientation = arg_match0(orientation, c("x", "y")),
          reverse = reverse
  )
}

#' @rdname position_identity_subdivide
#' @format NULL
#' @usage NULL
#' @export
PositionIdentityDodge <- ggproto('PositionIdentityDodge', PositionDodge,
                                 setup_data = function(self, data, params) {
                                   data <- data |>
                                     dplyr::group_by(x) |>
                                     mutate(n = y,
                                            y = sum(y),
                                            ymax = sum(y)) |>
                                   ggproto_parent(PositionDodge, self)$setup_data(data, params)
                                 }
)
