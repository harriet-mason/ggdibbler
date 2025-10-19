#' @name scale_distribution
NULL

#' @export
#' @rdname scale_distribution
scale_x_distribution <- function(
    name = ggplot2::waiver(), 
    breaks = ggplot2::waiver(),
    labels = ggplot2::waiver(),
    limits = NULL, 
    expand = ggplot2::waiver(),
    oob = scales::oob_keep, 
    guide = ggplot2::waiver(), 
    position = "bottom", 
    sec.axis = ggplot2::waiver()
    ) {
  sc <- distribution_scale(
    aesthetics = ggplot_global$x_aes,
    transform = "distribution",
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
#' @rdname scale_distribution
scale_y_distribution <- function(
    name = ggplot2::waiver(), 
    breaks = ggplot2::waiver(),
    labels = ggplot2::waiver(),
    limits = NULL, 
    expand = ggplot2::waiver(),
    oob = scales::oob_keep, 
    guide = ggplot2::waiver(), 
    position = "left", 
    sec.axis = ggplot2::waiver()
) {
  sc <- distribution_scale(
    aesthetics = ggplot_global$y_aes,
    transform = "distribution",
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
distribution_scale <- function(
    aesthetics,
    transform,
    trans = lifecycle::deprecated(),
    palette,
    breaks = ggplot2::waiver(),
    minor_breaks = ggplot2::waiver(),
    labels = ggplot2::waiver(),
    guide = guide,
    call = rlang::caller_call(),
    ...
    ) {
  call <- call %||% current_call()

  # x/y position aesthetics should use ScaleContinuousDistribution; others use ScaleContinuous
  if (all(aesthetics %in% c(ggplot_global$x_aes, ggplot_global$y_aes))) {
    scale_class <- ScaleContinuousDistribution
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
    transform = transform_distribution(),
    trans = trans,
    call = call,
    ...
    )
  sc$range <- DistributionRange$new()
  sc
}

#' @export
#' @keywords internal
#' @importFrom scales ContinuousRange
DistributionRange <- R6::R6Class(
  "DistributionRange",
  inherit = scales::ContinuousRange,
  list(
    train = function(x, call = rlang::caller_env()) {
      self$range <- train_distribution(x, self$range, call = call)
    },
    reset = function() {
      self$range <- NULL
    }
  )
)

#' @keywords internal
train_distribution <- function(new, existing = NULL, call = rlang::caller_env()) {
  if (is.null(new)) {
    return(existing)
  }
  # Transformed space is still distribution space
  if(is_distribution(new)){
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


#' Transformation for distributions (class Distribution)
#'
#' @export
#' @examples
#' dists <- distributional::dist_normal(seq(1:10), 1)
#' t <- transform_distribution()
#' t$transform(dists)
#' t$inverse(t$transform(dists))
transform_distribution <- function() {
  scales::new_transform(
    "distribution",
    transform = "force",
    #transform = function(x){
    #  unlist(distributional::generate(x,times = times))
    #  },
    inverse = "force"
  )
}


#' @keywords internal
ScaleContinuousDistribution <- ggproto( 
  "ScaleContinuousDistribution", 
  ggplot2::ScaleContinuous,
  secondary.axis = ggplot2::waiver(),
  # Distributions don't work with range training, so we override
  # According to scale documentation, we need to override...
  
  # Range
  range = DistributionRange$new(),
  
  # included this
  clone = function(self) {
    new <- ggproto(NULL, self)
    new$range <- DistributionRange$new()
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
    ggproto_parent(ggplot2::ScaleContinuous, self)$transform(x)
  },
  
  # Map
  # input: x = dist vector, limits = dist vector as limits
  # output:  a vector of mapped values in aesthetics space.
  map = function(self, x, limits = self$get_limits()) {
    x
  }
  
  # Might be OK to just ignore these three, as the range is already numeric?
  # get_limits() 
  # get_breaks()
  # get_labels()
)




