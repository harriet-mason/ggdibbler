# Define variables to stop CRAN checks from having a big ol' whinge
utils::globalVariables(c("geometry", "drawID", "fill", "unit"))

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
