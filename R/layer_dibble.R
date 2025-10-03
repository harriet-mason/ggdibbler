#' Layer function for dibble object
#' 
#' Identical to the ggplot2 layer function, except it sample expands the distributions before hand.
#' I would have made it as a proper ggplot2 extension, but ggplot gets all pissy about extending on layers
#' 
#' @importFrom ggplot2 aes layer
#' @importFrom rlang list2
#' @param times the number of times a sample value is draw from each distributional object.
#' @returns A ggplot2 layer
#' @inheritParams ggplot2::layer
#' @export
layer_dibble <- function (data=NULL, ..., times=times) {
  sample_expand(data=data, times=times) |>
    # feed in as group by to keep the "group" option open? (might not work)
    group_by(distID) |>
    ggplot2::layer(data, ...)
}

# layer.dibble <- layer_dibble


