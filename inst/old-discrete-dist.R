#' Position scales for discrete distributions
#' 
#' These scales allow for discrete distributions to be passed to the x and y position by mapping distribution objects
#' to discrete aesthetics.
#' These scale can be used similarly to the scale_*_discrete functions, but they do not
#' accept transformations.
#' If you want to transform your scale, you should apply a transformation through the coord_* functions,
#' as they are applied after the stat, so the existing ggplot infastructure can be used.
#' 
#' @examples
#' library(ggplot2)
#' # GGPLOT
#' p <- ggplot(diamonds, aes(x = cut, y = clarity))
#' p + geom_count(aes(size = after_stat(prop)))
#' # GGDIBBLER
#' q <- ggplot(uncertain_diamonds, aes(x = cut, y = clarity))
#' q + geom_count_sample(aes(size = after_stat(prop)), times=1, alpha=0.1)
#' @name scale_discrete_distribution
NULL

#' @export
#' @importFrom ggplot2 waiver
#' @importFrom scales oob_keep
#' @inheritParams ggplot2::scale_x_discrete
#' @rdname scale_discrete_distribution


scale_x_discrete_distribution <- function(
    name = waiver(), 
    palette = seq_len,
    expand = waiver(),
    guide = waiver(), 
    position = "bottom", 
    sec.axis = waiver(),
    continuous.limits = NULL,
    drop = TRUE,
    ...
) {
  sc <- discrete_distribution_scale(
    aesthetics = ggplot_global$x_aes, 
    name = name,
    palette = palette, 
    drop = drop,
    ...,
    expand = expand, 
    guide = guide, 
    position = position,
    continuous.limits = continuous.limits
  )
}


#' @export
#' @importFrom ggplot2 waiver
#' @importFrom scales oob_keep
#' @inheritParams ggplot2::scale_y_discrete
#' @rdname scale_discrete_distribution
scale_y_discrete_distribution <- function(
    name = waiver(), 
    palette = seq_len,
    expand = waiver(),
    guide = waiver(), 
    position = "left", 
    sec.axis = waiver(),
    continuous.limits = NULL,
    drop = TRUE,
    ...
) {
  sc <- discrete_distribution_scale(
    aesthetics = ggplot_global$y_aes, 
    name = name,
    palette = palette, 
    drop = drop,
    ...,
    expand = expand, 
    guide = guide, 
    position = position,
    continuous.limits = continuous.limits
  )
}



#' @keywords internal
discrete_distribution_scale <- function(
    aesthetics,
    palette,
    continuous.limits = NULL,
    call = rlang::caller_call(),
    guide = "legend",
    drop = TRUE,
    ...) {
  
  # x/y position aesthetics should use ScaleDiscreteDistributionPosition; others use ScaleDiscrete
  if (all(aesthetics %in% c(ggplot_global$x_aes, ggplot_global$y_aes))) {
    scale_class <- ScaleDiscreteDistributionPosition
  } else {
    scale_class <- ggplot2::ScaleDiscretePosition
  }
  
  sc <- ggplot2::discrete_scale(
    super = scale_class,
    aesthetics= aesthetics,
    palette = palette,
    guide = guide,
    call = call,
    drop = drop,
    ...
  )
  sc$range_c <- ContinuousDistributionRange$new()
  sc$continuous_limits <- continuous.limits
  sc
}


#' @keywords internal
DiscreteDistributionRange <- R6::R6Class(
  "DiscreteDistributionRange",
  inherit = scales::DiscreteRange,
  list(
    factor = NULL,
    train = function(x, drop = FALSE, na.rm = FALSE, call = rlang::caller_env()) {
      self$factor <- ifelse(distributional::is_distribution(new),
                            self$factor %||% is.factor(unlist(generate(x,1))),
                            self$factor %||% is.factor(x)) 
      self$range <- train_discrete_distribution(
        x,
        self$range,
        drop,
        na.rm,
        self$factor,
        call = call
      )
    },
    reset = function() {
      self$range <- NULL
      self$factor <- NULL
    }
  )
)

#' @keywords internal
train_discrete_distribution <- function(
    new,
    existing = NULL,
    drop = FALSE,
    na.rm = FALSE,
    fct = NA,
    call = rlang::caller_env()
) {
  if (is.null(new)) {
    return(existing)
  }
  if(distributional::is_distribution(new)){
    # make distribution into output
    new <- unlist(distributional::parameters(new)$x)
  }
  if (!is_discrete(new)) {
    example <- unique(new)
    example <- example[seq_len(pmin(length(example), 5))]
    cli::cli_abort(
      c(
        "Continuous value supplied to a discrete scale.",
        i = "Example values: {.and {.val {example}}}."
      ),
      call = call
    )
  }
  scales:::discrete_range(existing, new, drop = drop, na.rm = na.rm, fct = fct)
  
}

#' @keywords internal
ScaleDiscreteDistributionPosition <- ggproto( 
  "ScaleDiscreteDistributionPosition", 
  ggplot2::ScaleDiscretePosition,
  
  continuous_limits = NULL,
  
  # Train
  train = function(self, x) {
    print("TRAIN")
    print(head(x))
    print(class(x))
    if(distributional::is_distribution(x)){
      print("level1")
      if(is_discrete(unlist(generate(x,1)))){
        self$range$train(x, drop = self$drop, na.rm = !self$na.translate)
      }
    } else if (is_discrete(x)) {
      print("level2")
      self$range$train(x, drop = self$drop, na.rm = !self$na.translate)
    } else {
      print("level3")
      a <- self$range_c$train(x)
      print(head(a))
      a
    }
  },
  
  # Range
  range = DiscreteDistributionRange$new(),
  
  # included this
  clone = function(self) {
    new <- ggproto(NULL, self)
    new$range <- DiscreteDistributionRange$new()
    new
  },
  
  # Map
  # input: x = dist vector, limits = dist vector as limits
  # output:  a vector of mapped values in aesthetics space.
  map = function(self, x, limits = self$get_limits()) {
    if (is_discrete(x)){
      ggplot2::ggproto_parent(ggplot2::ScaleDiscretePosition, self)$map(x)
    } else if (is.numeric(x)){
      x
      
    }else {
      #print(x)
      old_outcomes <- distributional::parameters(x)$x
      #print(head(old_outcomes))
      new_outcomes <- lapply(old_outcomes, 
                             discrete_outcomes <- function(x){
                               seq(length(x))
                               #ggplot2::ggproto_parent(ggplot2::ScaleDiscretePosition, self)$map(x)
                             }
      )
      print(head(new_outcomes))
      #print(head(new_outcomes))
      probs <- distributional::parameters(x)$p
      #print(head(probs))
      # new_param <- ggplot2::ggproto_parent(ggplot2::ScaleDiscretePosition, self)$map(old_param)
      x <- dist_categorical(prob = probs, outcomes = new_outcomes)
      print(head(x))
      x
    }
  }
  
)


# stole from ggplot
#' @keywords internal
is_discrete <- function(x) {
  is.factor(x) || is.character(x) || is.logical(x)
}
