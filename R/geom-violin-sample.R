#' Violin plots with uncertainty
#' 
#' Identical to geom_violin, except that it will accept a distribution in
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_violin
#' @importFrom ggplot2 make_constructor GeomViolin
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' 
#' # have to make factor variable, probably easier ways to do it
#' uncertain_mtcars2 <- uncertain_mtcars |>
#'   rowwise() |> #must have this or the distributions get mixed up
#'   mutate(cyl_factor = dist_sample(list(factor(unlist(generate(cyl,100))))))
#' 
#' # plot set up
#' p <- ggplot(mtcars, aes(factor(cyl), mpg))
#' q <- ggplot(uncertain_mtcars2, aes(cyl_factor, mpg))
#' 
#' # ggplot
#' p + geom_violin()
#' # ggdibbler
#' q + geom_violin_sample(alpha=0.1)
#' 
#' # Orientation follows the discrete axis
#' # ggplot
#' ggplot(mtcars, aes(mpg, factor(cyl))) +
#'   geom_violin()
#' # ggdibbler
#' ggplot(uncertain_mtcars2, aes(mpg, cyl_factor)) +
#'   geom_violin_sample(alpha=0.1)
#' 
#' # ggplot
#' p + geom_violin() + 
#'   geom_jitter(height = 0, width = 0.1)
#' # ggdibbler
#' q + geom_violin_sample(alpha=0.1) + 
#'   geom_jitter_sample(height = 0, width = 0.1, size=0.1)
#' 
#' # Scale maximum width proportional to sample size:
#' # ggplot
#' p + geom_violin(scale = "count")
#' # ggdibbler
#' q + geom_violin_sample(scale = "count")
#' 
#' # Scale maximum width to 1 for all violins:
#' # ggplot
#' p + geom_violin(scale = "width")
#' # ggdibbler
#' q + geom_violin_sample(scale = "width", alpha=0.1)
#' 
#' # Default is to trim violins to the range of the data. To disable:
#' # ggplot
#' p + geom_violin(trim = FALSE)
#' # ggdibbler
#' q + geom_violin_sample(trim = FALSE, alpha=0.1)
#' 
#' # Use a smaller bandwidth for closer density fit (default is 1).
#' # ggplot
#' p + geom_violin(adjust = .5)
#' # ggdibbler
#' q + geom_violin_sample(adjust = .5, alpha=0.1)
#' 
#' 
#' # Add aesthetic mappings
#' 
#' # ggplot
#' ggplot(mtcars, aes(factor(cyl), mpg)) + 
#'   geom_violin(aes(fill = cyl))
#' # ggdibbler
#' ggplot(uncertain_mtcars2, aes(cyl_factor, mpg)) + 
#'   geom_violin_sample(aes(fill = after_stat(x))) 
#' 
#' # ggplot
#' p + geom_violin(aes(fill = factor(cyl)))
#' # ggdibbler
#' q + geom_violin_sample(aes(fill = factor(after_stat(x))))
#' 
#' # Set aesthetics to fixed value
#' # ggplot
#' p + geom_violin(fill = "grey80", colour = "#3366FF")
#' # ggdibbler
#' q + geom_violin_sample(fill = "grey80", colour = "#3366FF", alpha=0.1)
#' @export
geom_violin_sample <- make_constructor(ggplot2::GeomViolin, stat = "ydensity_sample", times=10)
