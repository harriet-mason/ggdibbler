#' Uncertain Connected observations
#' 
#' Identical to geom_path, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_path
#' @importFrom ggplot2 make_constructor GeomPath
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' # geom_line() is suitable for time series
#' #ggplot
#' ggplot(economics, aes(date, unemploy)) + geom_line() 
#' #ggdibbler
#' ggplot(uncertain_economics, aes(date, unemploy)) + 
#'   geom_line_sample(alpha=0.1) 
#' 
#' # You can get a timeseries that run vertically by setting the orientation
#' # ggplot
#' ggplot(economics, aes(unemploy, date)) + 
#'   geom_line(orientation = "y")
#' # ggdibbler
#' ggplot(uncertain_economics, aes(unemploy, date)) + 
#'   geom_line_sample(orientation = "y", alpha=0.1)

#' # geom_step() is useful when you want to highlight exactly when
#' # the y value changes
#' recent <- economics[economics$date > as.Date("2013-01-01"), ]
#' uncertain_recent <- uncertain_economics[uncertain_economics$date > as.Date("2013-01-01"), ]
#' # geom line
#' ggplot(recent, aes(date, unemploy)) + geom_line() #ggplot
#' ggplot(uncertain_recent, aes(date, unemploy)) + geom_line_sample(alpha=0.3) #ggdibbler
#' ggplot(recent, aes(date, unemploy)) + geom_step() #ggplot
#' ggplot(uncertain_recent, aes(date, unemploy)) + geom_step_sample(alpha=0.3) #ggdibbler
#' 
#' # Changing parameters 
#' # ggplot
#' ggplot(economics, aes(date, unemploy)) +
#'   geom_line(colour = "red")
#' # ggdibbler
#' ggplot(uncertain_economics, aes(date, unemploy)) +
#'   geom_line_sample(colour = "red", alpha=0.1)
#' 
#' # Use the arrow parameter to add an arrow to the line
#' # See ?arrow for more details
#' # ggplot
#' c <- ggplot(economics, aes(x = date, y = pop))
#' c + geom_line(arrow = arrow())
#' c + geom_line(
#'   arrow = arrow(angle = 15, ends = "both", type = "closed"))
#' # ggdibbler
#' d <- ggplot(uncertain_economics, aes(x = date, y = pop))
#' d + geom_line_sample(arrow = arrow(), alpha=0.1)
#' d + geom_line_sample(arrow = arrow(angle = 15, ends = "both", type = "closed"),
#'                      alpha=0.1)
#' @export
geom_path_sample <- make_constructor(ggplot2::GeomPath, stat = "sample", times=10)

#' @export
#' @inheritParams ggplot2::geom_line
#' @importFrom ggplot2 make_constructor GeomLine
#' @rdname geom_path_sample
geom_line_sample <- make_constructor(ggplot2::GeomLine, stat = "sample", times=10, orientation = NA)

#' @export
#' @inheritParams ggplot2::geom_line
#' @importFrom ggplot2 make_constructor GeomStep
#' @rdname geom_path_sample
geom_step_sample <- make_constructor(ggplot2::GeomStep, stat = "sample", times=10, orientation = NA)