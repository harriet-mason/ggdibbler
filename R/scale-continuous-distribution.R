#' Position scales for continuous distributions
#' 
#' These scales allow for distributions to be passed to the x and y position by mapping distribution objects
#' to continuous aesthetics.
#' These scale can be used similarly to the scale_*_continuous functions, but they do not
#' accept transformations.
#' If you want to transform your scale, you should apply a transformation through the coord_* functions,
#' as they are applied after the stat, so the existing ggplot infastructure can be used.
#' For example, if you would like a log transformation of the x axis, plot + coord_transform(x = "log")
#' would work fine.
#' 
#' @examples
#' library(ggplot2)
#' library(distributional)
#' set.seed(1997)
#' point_data <- data.frame(xvar = c(dist_uniform(2,3),
#'                                   dist_normal(3,2),
#'                                   dist_exponential(3)),
#'                          yvar = c(dist_gamma(2,1), 
#'                                   dist_sample(x = list(rnorm(100, 5, 1))), 
#'                                   dist_exponential(1)))
#' ggplot(data = point_data) + 
#'   geom_point_sample(aes(x=xvar, y=yvar)) +
#'   scale_x_distribution(name="Hello, I am a random variable", limits = c(-5, 10)) +
#'   scale_y_distribution(name="I am also a random variable")
#' 
#' @name scale_continuous_distribution
NULL

#' @export
#' @importFrom ggplot2 waiver
#' @importFrom scales oob_keep
#' @inheritParams ggplot2::scale_x_continuous
#' @rdname scale_continuous_distribution
scale_x_continuous_distribution <- function(
    name = waiver(), 
    breaks = waiver(),
    labels = waiver(),
    limits = NULL, 
    expand = waiver(),
    oob = oob_keep, 
    guide = waiver(), 
    position = "bottom", 
    sec.axis = waiver(),
    ...
    ) {
  sc <- continuous_distribution_scale(
    aesthetics = ggplot_global$x_aes,
    transform = "identity",
    name = name,
    palette = identity,
    breaks = breaks,
    labels = labels,
    guide = guide,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}


#' @export
#' @importFrom ggplot2 waiver
#' @importFrom scales oob_keep
#' @inheritParams ggplot2::scale_y_continuous
#' @rdname scale_continuous_distribution
scale_y_continuous_distribution <- function(
    name = waiver(), 
    breaks = waiver(),
    labels = waiver(),
    limits = NULL, 
    expand = waiver(),
    oob = scales::oob_keep, 
    guide = waiver(), 
    position = "left", 
    sec.axis = waiver(),
    ...
) {
  sc <- continuous_distribution_scale(
    aesthetics = ggplot_global$y_aes,
    transform = "identity",
    name = name,
    palette = identity,
    breaks = breaks,
    labels = labels,
    guide = guide,
    limits = limits,
    expand = expand,
    oob = oob,
    position = position
  )
}

#' @keywords internal
continuous_distribution_scale <- function(
    aesthetics,
    transform,
    trans = lifecycle::deprecated(),
    palette,
    breaks = ggplot2::waiver(),
    minor_breaks = ggplot2::waiver(),
    labels = ggplot2::waiver(),
    guide = "legend",
    call = rlang::caller_call(),
    ...) {

  # x/y position aesthetics should use ScaleContinuousDistributionPosition; others use ScaleContinuous
  if (all(aesthetics %in% c(ggplot_global$x_aes, ggplot_global$y_aes))) {
    scale_class <- ScaleContinuousDistributionPosition
  } else {
    scale_class <- ggplot2::ScaleContinuous
  }
  
  sc <- ggplot2::continuous_scale(
    super = scale_class,
    aesthetics= aesthetics,
    palette = palette,
    breaks = breaks,
    minor_breaks = minor_breaks,
    labels = labels,
    guide = guide,
    transform = transform,
    trans = trans,
    call = call,
    ...
    )
  sc$range <- ContinuousDistributionRange$new()
  sc
}

#' @keywords internal
ContinuousDistributionRange <- R6::R6Class(
  "ContinuousDistributionRange",
  inherit = scales::ContinuousRange,
  list(
    train = function(x, call = rlang::caller_env()) {
      self$range <- train_continuous_distribution(x, self$range, call = call)
    },
    reset = function() {
      self$range <- NULL
    }
  )
)

#' @keywords internal
train_continuous_distribution <- function(new, existing = NULL, call = rlang::caller_env()) {
  if (is.null(new)) {
    return(existing)
  }
  # Transformed space is still distribution space
  if(distributional::is_distribution(new)){
    new <- rlang::try_fetch(
      suppressWarnings(range(unlist(distributional::generate(new, times = 1000)), 
                             na.rm = TRUE, finite = TRUE)),
      error = function(cnd) new
    )
  }
  if(is.double(new)|is.numeric(new)){
    new <- rlang::try_fetch(
      suppressWarnings(range(new, na.rm = TRUE, finite = TRUE)),
      error = function(cnd) new
    )
  }
}



#' @keywords internal
ScaleContinuousDistributionPosition <- ggproto( 
  "ScaleContinuousDistributionPosition", 
  ggplot2::ScaleContinuousPosition,
  secondary.axis = ggplot2::waiver(),
  # Distributions don't work with range training, so we override
  # According to scale documentation, we need to override...
  
  # Range
  range = ContinuousDistributionRange$new(),
  
  # included this
  clone = function(self) {
    new <- ggproto(NULL, self)
    new$range <- ContinuousDistributionRange$new()
    new
  },
  
  # Train
  train = function(self, x) {
    if (length(x) == 0) {
      return()
    }
    self$range$train(x, call = self$call)
  },

  # (transform_df just applies the transformation to each column of data frame - it's fine as is)
  # Transform
  # input: x - A vector of the relevant aesthetics
  # output: a vector of transformed values.
  transform = function(self, x) {
    if (rlang::is_bare_numeric(x)) {
      cli::cli_abort(
        c(
          "A {.cls numeric} value was passed to a {.field distributional} scale.",
          i = "Please use the distributional package to create distribution values."
        ),
        call = self$call
      )
    }
    ggplot2::ggproto_parent(ggplot2::ScaleContinuousPosition, self)$transform(x)
  },
  
  # Map
  # input: x = dist vector, limits = dist vector as limits
  # output:  a vector of mapped values in aesthetics space.
  map = function(self, x, limits = self$get_limits()) {
    x
  }
  
)




