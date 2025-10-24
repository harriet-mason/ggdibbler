# Define variables to stop CRAN checks from having a big ol' whinge
utils::globalVariables(c("geometry", "drawID", "fill", "unit"))

##################### FUNCTIONS I HAD TO STEAL FROM GGPLOT ############

# Wrapping unique0() to accept NULL
unique0 <- function(x, ...) if (is.null(x)) x else vctrs::vec_unique(x, ...)

empty <- function(df) {
  is.null(df) || nrow(df) == 0 || ncol(df) == 0 || is_waiver(df)
}

# ggplot2:::ggplot_global
ggplot_global <- list(
  x_aes = c(
    "x",
    "xmin",
    "xmax",
    "xend",
    "xintercept",
    "xmin_final",
    "xmax_final",
    "xlower",
    "xmiddle",
    "xupper",
    "x0"
  ),
  y_aes = c(
    "y",
    "ymin",
    "ymax",
    "yend",
    "yintercept",
    "ymin_final",
    "ymax_final",
    "lower",
    "middle",
    "upper",
    "y0"
  )
)
