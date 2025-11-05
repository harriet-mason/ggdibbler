#' Dot plot with uncertainty
#' 
#' Identical to geom_dotplot, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_dotplot
#' @importFrom ggplot2 GeomDotplot layer
#' @importFrom rlang list2 arg_match0
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot()
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(alpha=0.2)
#' 
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(binwidth = 1.5)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(binwidth = 1.5, alpha=0.2)
#' 
#' # Use fixed-width bins
#' #ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(method="histodot", binwidth = 1.5)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(method="histodot", binwidth = 1.5, 
#'                       alpha=0.2)
#' 
#' # Some other stacking methods
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(binwidth = 1.5, stackdir = "center")
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(binwidth = 1.5, stackdir = "center", alpha=0.2)
#' 
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(binwidth = 1.5, stackdir = "centerwhole")
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(binwidth = 1.5, stackdir = "centerwhole",
#'                       alpha=0.2)
#' 
#' # y axis isn't really meaningful, so hide it
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) + 
#'   geom_dotplot(binwidth = 1.5) +
#'   scale_y_continuous(NULL, breaks = NULL)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) + 
#'   geom_dotplot_sample(binwidth = 1.5, alpha=0.2) +
#'   scale_y_continuous(NULL, breaks = NULL)
#' 
#' # Overlap dots vertically
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(binwidth = 1.5, stackratio = .7)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(binwidth = 1.5, stackratio = .7,
#'                       alpha=0.2)
#' 
#' # Expand dot diameter
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(binwidth = 1.5, dotsize = 1.25)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(binwidth = 1.5, dotsize = 1.25,
#'                       alpha=0.2)
#' 
#' # Change dot fill colour, stroke width
#' # ggplot
#' ggplot(mtcars, aes(x = mpg)) +
#'   geom_dotplot(binwidth = 1.5, fill = "white", stroke = 2)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = mpg)) +
#'   geom_dotplot_sample(binwidth = 1.5, fill = "white", stroke = 2,
#'                       alpha=0.2)
#' 
#' # Examples with stacking along y axis instead of x
#' # ggplot
#' ggplot(mtcars, aes(x = 1, y = mpg)) +
#'   geom_dotplot(binaxis = "y", stackdir = "center")
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(x = 1, y = mpg)) +
#'   geom_dotplot_sample(binaxis = "y", stackdir = "center",
#'                       alpha=0.2) +
#'   scale_y_continuous_distribution(limits=c(9, 36))
#' @export
geom_dotplot_sample <- function(mapping = NULL, data = NULL,
                         position = "identity",
                         ...,
                         times = 10,
                         binwidth = NULL,
                         binaxis = "x",
                         method = "dotdensity",
                         binpositions = "bygroup",
                         stackdir = "up",
                         stackratio = 1,
                         dotsize = 1,
                         stackgroups = FALSE,
                         origin = NULL,
                         right = TRUE,
                         width = 0.9,
                         drop = FALSE,
                         na.rm = FALSE,
                         show.legend = NA,
                         inherit.aes = TRUE) {
  # If identical(position, "stack") or position is position_stack(), tell them
  # to use stackgroups=TRUE instead. Need to use identical() instead of ==,
  # because == will fail if object is position_stack() or position_dodge()
  if (!is.null(position) &&
      (identical(position, "stack") || (inherits(position, "PositionStack"))))
    cli::cli_inform("{.code position = \"stack\"} doesn't work properly with {.fn geom_dotplot}. Use {.code stackgroups = TRUE} instead.")
  
  if (stackgroups && method == "dotdensity" && binpositions == "bygroup")
    cli::cli_inform(c(
      '{.fn geom_dotplot} called with {.code stackgroups = TRUE} and {.code method = "dotdensity"}.",
      i = "Do you want {.code binpositions = "all"} instead?'
    ))
  
  stackdir <- rlang::arg_match0(stackdir, c("up", "down", "center", "centerwhole"), "stackdir")
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = StatBindotSample,
    geom = ggplot2::GeomDotplot,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      times = times,
      binaxis = binaxis,
      binwidth = binwidth,
      binpositions = binpositions,
      method = method,
      origin = origin,
      right = right,
      width = width,
      drop = drop,
      stackdir = stackdir,
      stackratio = stackratio,
      dotsize = dotsize,
      stackgroups = stackgroups,
      na.rm = na.rm,
      ...
    )
  )
}
