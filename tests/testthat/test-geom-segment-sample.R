library(vdiffr)
library(ggplot2)
library(distributional)

df <- data.frame(x1 = 2.62, x2 = 3.57, 
                 y1 = 21.0, y2 = 15.0)
uncertain_df <- data.frame(x1 = dist_normal(2.62, 0.1), 
                           x2 = dist_normal(3.57,0.1), 
                           y1 = dist_normal(21.0, 0.1), 
                           y2 = dist_normal(15.0,0.1))


a <- ggplot(uncertain_mtcars, aes(wt, mpg)) +
  geom_point_sample(size=0.1) +
  scale_x_continuous_distribution(limits = c(1,6)) +
  scale_y_continuous_distribution(limits = c(8,36))

# You can also use geom_segment to recreate plot(type = "h") :
set.seed(1)
# deterministic data
counts <- as.data.frame(table(x = rpois(100,5)))
counts$x <- as.numeric(as.character(counts$x))
# random data
uncertain_counts <- counts
uncertain_counts$Freq <- dist_binomial(counts$Freq, 0.9)

test_that("geom_segment_sample tests", {
  
  set.seed(876)
  
  p1 <- a +
    geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "curve"), 
                      data = uncertain_df, alpha=0.5) +
    geom_segment_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"), 
                        data = uncertain_df, alpha=0.5)
  
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_counts, aes(x, Freq)) +
    geom_segment_sample(aes(xend = x, yend = 0), linewidth = 10, lineend = "butt", alpha=0.1) +
    scale_x_continuous_distribution(limits = c(0,12)) +
    scale_y_continuous_distribution(limits = c(0,25)) 
  
  expect_doppelganger("Example 2", p2)
  
}
)

################ PASS #################
############### FAIL #################
############## UNTESTED #################


# if (requireNamespace('maps', quietly = TRUE)) {
#   ggplot(seals, aes(long, lat)) +
#     geom_segment(aes(xend = long + delta_long, yend = lat + delta_lat),
#                  arrow = arrow(length = unit(0.1,"cm"))) +
#     annotation_borders("state")
# }
# 
# # Use lineend and linejoin to change the style of the segments
# df2 <- expand.grid(
#   lineend = c('round', 'butt', 'square'),
#   linejoin = c('round', 'mitre', 'bevel'),
#   stringsAsFactors = FALSE
# )
# df2 <- data.frame(df2, y = 1:9)
# ggplot(df2, aes(x = 1, y = y, xend = 2, yend = y, label = paste(lineend, linejoin))) +
#   geom_segment(
#     lineend = df2$lineend, linejoin = df2$linejoin,
#     size = 3, arrow = arrow(length = unit(0.3, "inches"))
#   ) +
#   geom_text(hjust = 'outside', nudge_x = -0.2) +
#   xlim(0.5, 2)

# with(counts, plot(x, Freq, type = "h", lwd = 10))

