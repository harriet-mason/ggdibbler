#' @importFrom ggplot2 ggproto StatEcdf
#' @rdname stat_ecdf_sample
#' @format NULL
#' @usage NULL
#' @export
StatEcdfSample <- ggplot2::ggproto("StatEcdfSample", ggplot2::StatEcdf,
                                   setup_params = function(self, data, params) {
                                     times <- params$times
                                     params$times <- 1
                                     data <- dibble_to_tibble(data, params)
                                     params <- ggplot2::ggproto_parent(ggplot2::StatEcdf, self)$setup_params(data, params)
                                     params$times <- times
                                     params
                                   },
                                   
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' Compute uncertain empirical cumulative distributions
#' 
#' Identical to stat_ecdf, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_ecdf
#' @importFrom ggplot2 make_constructor 
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' set.seed(44)
#' # df
#' df <- data.frame(
#'   x = c(rnorm(100, 0, 3), rnorm(100, 0, 10)),
#'   g = gl(2, 100)
#' )
#' uncertain_df <- df |>
#'   group_by(x) |>
#'   mutate(x = dist_normal(x, runif(1,0,5)),
#'          g_pred = dist_bernoulli(0.9-0.8*(2-as.numeric(g)))
#'   )
#' # ggplot
#' ggplot(df, aes(x)) +
#'   stat_ecdf(geom = "step")
#' # ggdibbler
#' ggplot(uncertain_df, aes(x)) +
#'   stat_ecdf_sample(geom = "step", alpha=0.3)
#' 
#' # Multiple ECDFs
#' # ggplot
#' ggplot(df, aes(x, colour = g)) +
#'   stat_ecdf()
#' # ggdibbler 1
#' ggplot(uncertain_df, aes(x, colour = g)) +
#'   stat_ecdf_sample(alpha=0.3)
#' @export
stat_ecdf_sample <- make_constructor(StatEcdfSample, geom = "step", 
                                     times = 10, seed = NULL)
