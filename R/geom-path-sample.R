#' Uncertain Connected observations
#' 
#' Identical to geom_path, geom_line, and geom_step, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_path
#' @importFrom ggplot2 make_constructor GeomPath
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' 
#' #ggplot
#' ggplot(economics, aes(date, unemploy)) + geom_line() 
#' #ggdibbler
#' ggplot(uncertain_economics, aes(date, unemploy)) + 
#'   geom_line_sample() 
#'   
#' # geom_step() is useful when you want to highlight exactly when
#' # the y value changes
#' recent <- economics[economics$date > as.Date("2013-01-01"), ]
#' uncertain_recent <- uncertain_economics[uncertain_economics$date > as.Date("2013-01-01"), ]
#' # geom line
#' ggplot(recent, aes(date, unemploy)) + geom_step()#ggplot
#' ggplot(uncertain_recent, aes(date, unemploy)) + geom_step_sample()#ggdibbler
#' 
#' # geom_path lets you explore how two variables are related over time,
#' # ggplot
#' m + geom_path(aes(colour = as.numeric(date)))
#' # ggdibbler
#' n  + geom_path_sample(aes(colour = as.numeric(date)))
#' 
#' # You can use NAs to break the line.
#' df <- data.frame(x = 1:5, y = c(1, 2, NA, 4, 5))
#' uncertain_df <- df |> mutate(y=dist_normal(y, 0.3))
#' # ggplot
#' ggplot(df, aes(x, y)) + geom_point() + geom_line()
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y)) + 
#'   geom_point_sample(seed=33) + 
#'   geom_line_sample(seed=33) 
#' @export
geom_path_sample <- make_constructor(ggplot2::GeomPath, stat = "identity_sample", 
                                     times=10, alpha=	0.3/log(times), seed = NULL)

#' @export
#' @inheritParams ggplot2::geom_line
#' @importFrom ggplot2 make_constructor GeomLine
#' @rdname geom_path_sample
geom_line_sample <- make_constructor(ggplot2::GeomLine, stat = "identity_sample", 
                                     times=10, alpha=	0.3/log(times), seed = NULL,
                                     orientation = NA)

#' @export
#' @inheritParams ggplot2::geom_line
#' @importFrom ggplot2 make_constructor GeomStep
#' @rdname geom_path_sample
geom_step_sample <- make_constructor(ggplot2::GeomStep, stat = "identity_sample", 
                                     times=10, alpha=	0.6/log(times), seed = NULL,
                                     orientation = NA)


