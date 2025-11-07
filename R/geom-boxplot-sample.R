#' An uncertain box and whiskers plot (in the style of Tukey)
#' 
#' Identical to geom_boxplot, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_boxplot
#' @importFrom ggplot2 GeomSmooth aes layer
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' # ggplot
#' p <- ggplot(mpg, aes(class, hwy))
#' p + geom_boxplot(alpha=0.5)
#' 
#' # using alpha to manage overplotting
#' q <- ggplot(uncertain_mpg, aes(class, hwy)) 
#' q + geom_boxplot_sample(alpha=0.1) 
#' 
#' # ggdibbler: e.g. only one random variable 
#' # (If you only have one random variable, there is less uncertainty)
#' uncertain_mpg_new <- uncertain_mpg
#' uncertain_mpg_new$class <- mpg$class
#' r <- ggplot(uncertain_mpg_new, aes(class, hwy))  
#' r  + geom_boxplot_sample(alpha=0.1) 
#' 
#' # Orientation follows the discrete axis
#' # ggplot
#' ggplot(mpg, aes(hwy, class)) + 
#'   geom_boxplot()
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(hwy, class)) + 
#'   geom_boxplot_sample(alpha=0.1)
#' 
#' # ggplot
#' p + geom_boxplot(notch = TRUE)
#' # ggdibbler
#' q + geom_boxplot_sample(alpha=0.1, notch = TRUE) 
#' 
#' # ggplot
#' p + geom_boxplot(varwidth = TRUE)
#' # ggdibbler
#' q + geom_boxplot_sample(alpha=0.1, varwidth = TRUE) 
#' 
#' #ggplot
#' p + geom_boxplot(fill = "white", colour = "#3366FF")
#' #ggdibbler
#' q + geom_boxplot_sample(alpha=0.1, fill = "white", colour = "#3366FF") 
#' 
#' # By default, outlier points match the colour of the box. Use
#' # outlier.colour to override
#' p + geom_boxplot(outlier.colour = "red", outlier.shape = 1)
#' q + geom_boxplot_sample(alpha=0.1, outlier.colour = "red", outlier.shape = 1) 
#' 
#' # Remove outliers when overlaying boxplot with original data points
#' p + geom_boxplot(outlier.shape = NA) + geom_jitter(width = 0.2)
#' q + geom_boxplot_sample(alpha=0.1, outlier.shape = NA) + 
#'   geom_jitter_sample(size= 0.1, width = 0.2)
#'   
#' @export
geom_boxplot_sample <- function(mapping = NULL, data = NULL, #position = "dodge2",
                         stat = "boxplot_sample", times=10, position = "identity",
                         ...,
                         outliers = TRUE,
                         outlier.colour = NULL,
                         outlier.color = NULL,
                         outlier.fill = NULL,
                         outlier.shape = NULL,
                         outlier.size = NULL,
                         outlier.stroke = 0.5,
                         outlier.alpha = NULL,
                         whisker.colour    = NULL,
                         whisker.color     = NULL,
                         whisker.linetype  = NULL,
                         whisker.linewidth = NULL,
                         staple.colour     = NULL,
                         staple.color      = NULL,
                         staple.linetype   = NULL,
                         staple.linewidth  = NULL,
                         median.colour     = NULL,
                         median.color      = NULL,
                         median.linetype   = NULL,
                         median.linewidth  = NULL,
                         box.colour        = NULL,
                         box.color         = NULL,
                         box.linetype      = NULL,
                         box.linewidth     = NULL,
                         notch = FALSE,
                         notchwidth = 0.5,
                         staplewidth = 0,
                         varwidth = FALSE,
                         na.rm = FALSE,
                         orientation = NA,
                         show.legend = NA,
                         inherit.aes = TRUE) {
  
  # REIMPLEMENT WHEN TIERED POSITION IS IMPLEMENTED?
  # varwidth = TRUE is not compatible with preserve = "total"
  # if (is.character(position)) {
  #  if (varwidth == TRUE) position <- position_dodge2(preserve = "single")
  # } else {
  #  if (identical(position$preserve, "total") & varwidth == TRUE) {
  #    cli::cli_warn("Can't preserve total widths when {.code varwidth = TRUE}.")
  #    position$preserve <- "single"
  #  }
  # }
  
  outlier_gp <- list(
    colour = outlier.color %||% outlier.colour,
    fill   = outlier.fill,
    shape  = outlier.shape,
    size   = outlier.size,
    stroke = outlier.stroke,
    alpha  = outlier.alpha
  )
  
  whisker_gp <- list(
    colour    = whisker.color %||% whisker.colour,
    linetype  = whisker.linetype,
    linewidth = whisker.linewidth
  )
  
  staple_gp <- list(
    colour    = staple.color %||% staple.colour,
    linetype  = staple.linetype,
    linewidth = staple.linewidth
  )
  
  median_gp <- list(
    colour    = median.color %||% median.colour,
    linetype  = median.linetype,
    linewidth = median.linewidth
  )
  
  box_gp <- list(
    colour    = box.color %||% box.colour,
    linetype  = box.linetype,
    linewidth = box.linewidth
  )
  
  ggplot2:::check_number_decimal(staplewidth)
  ggplot2:::check_bool(outliers)
  
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomBoxplot,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      times = times,
      outliers = outliers,
      outlier_gp = outlier_gp,
      whisker_gp = whisker_gp,
      staple_gp  = staple_gp,
      median_gp  = median_gp,
      box_gp     = box_gp,
      notch = notch,
      notchwidth = notchwidth,
      staplewidth = staplewidth,
      varwidth = varwidth,
      na.rm = na.rm,
      orientation = orientation,
      ...
    )
  )
}

