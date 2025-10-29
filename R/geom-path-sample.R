#' Uncertain Connected observations
#' 
#' Identical to geom_path, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_path
#' @importFrom ggplot2 make_constructor GeomPath
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
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
#' ggplot(recent, aes(date, unemploy)) + geom_line()#ggplot
#' ggplot(uncertain_recent, aes(date, unemploy)) + geom_line_sample(alpha=0.3)#ggdibbler
#' ggplot(recent, aes(date, unemploy)) + geom_step()#ggplot
#' ggplot(uncertain_recent, aes(date, unemploy)) + geom_step_sample(alpha=0.3)#ggdibbler
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
#' # ggdibbler
#' d <- ggplot(uncertain_economics, aes(x = date, y = pop))
#' d + geom_line_sample(arrow = arrow(), alpha=0.1)
#' # ggplot
#' c + geom_line(
#'   arrow = arrow(angle = 15, ends = "both", type = "closed"))
#' # ggdibbler
#' d + geom_line_sample(arrow = arrow(angle = 15, ends = "both", type = "closed"),
#'                      alpha=0.1)
#'                      
#' # separate by colour and use "timeseries" legend key glyph
#' # ggplot
#' ggplot(economics_long, aes(date, value01, colour = variable)) +
#'   geom_line(key_glyph = "timeseries")
#' # ggdibbler (this looks bad because of my poorly chosen variance, not the plot
#' ggplot(uncertain_economics_long, aes(date, value0, colour = variable)) +
#'   geom_line_sample(key_glyph = "timeseries", alpha=0.1) 
#' 
#' # geom_path lets you explore how two variables are related over time,
#' # e.g. unemployment and personal savings rate
#' # ggplot
#' m <- ggplot(economics, aes(unemploy, psavert))
#' m + geom_path()
#' # ggdibbler
#' n <- ggplot(uncertain_economics, aes(unemploy, psavert))
#' n + geom_path_sample(alpha=0.3)
#' # ggplot
#' m + geom_path(aes(colour = as.numeric(date)))
#' # ggdibbler
#' n  + geom_path_sample(aes(colour = as.numeric(date)), alpha=0.3)
#' 
#' # You can use NAs to break the line.
#' df <- data.frame(x = 1:5, y = c(1, 2, NA, 4, 5))
#' uncertain_df <- df |> mutate(y=dist_normal(y, 0.3))
#' # ggplot
#' ggplot(df, aes(x, y)) + geom_point() + geom_line()
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y)) + geom_point_sample() + geom_line_sample() 
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