# library(vdiffr)
# 
# test_that("geom_**_sample tests", {
#   
#   set.seed(***)
#   
#   p* <- ggplot()
#   expect_doppelganger("Example 1", p1)
#   
# }
# )

# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################
library(ggplot2)
# ggplot
p <- ggplot(mpg, aes(class, hwy))
p + geom_boxplot()

# samples with deterministic data
r <- ggplot(mpg, aes(class, hwy))
r + geom_boxplot_sample(alpha=0.1)

# random variables
q <- ggplot(uncertain_mpg, aes(class, hwy))
q + geom_boxplot_sample(alpha=0.01, position="identity") +
  scale_y_continuous_distribution(limits=c(11,50))

# simplify the problem a bit
uncertain_mpg_new <- uncertain_mpg
uncertain_mpg_new$class <- mpg$class
q <- ggplot(uncertain_mpg_new, aes(class, hwy))
q + geom_boxplot_sample(aes(fill = as.factor(after_stat(x))), alpha=0.05) +
  scale_y_continuous_distribution(limits=c(11,50)) +
  labs(fill = "class")

q <- ggplot(uncertain_mpg, aes(class, hwy))
q + geom_point_sample(aes(fill = as.factor(after_stat(x))), alpha=0.1) 

# maybe more uncertainty will make it more visible?
smaller_uncertain_mpg <- uncertain_mpg_new %>%
  sample_n(20)

q <- ggplot(smaller_uncertain_mpg, aes(class, hwy))
q + geom_boxplot_sample(alpha=0.01, position="identity") +
  scale_y_continuous_distribution(limits=c(11,50))



# Orientation follows the discrete axis
ggplot(mpg, aes(hwy, class)) + geom_boxplot()

p + geom_boxplot(notch = TRUE)
p + geom_boxplot(varwidth = TRUE)
p + geom_boxplot(fill = "white", colour = "#3366FF")
# By default, outlier points match the colour of the box. Use
# outlier.colour to override
p + geom_boxplot(outlier.colour = "red", outlier.shape = 1)
# Remove outliers when overlaying boxplot with original data points
p + geom_boxplot(outlier.shape = NA) + geom_jitter(width = 0.2)

# Boxplots are automatically dodged when any aesthetic is a factor
p + geom_boxplot(aes(colour = drv))

# You can also use boxplots with continuous x, as long as you supply
# a grouping variable. cut_width is particularly useful
ggplot(diamonds, aes(carat, price)) +
  geom_boxplot()
ggplot(diamonds, aes(carat, price)) +
  geom_boxplot(aes(group = cut_width(carat, 0.25)))
# Adjust the transparency of outliers using outlier.alpha
ggplot(diamonds, aes(carat, price)) +
  geom_boxplot(aes(group = cut_width(carat, 0.25)), outlier.alpha = 0.1)


# It's possible to draw a boxplot with your own computations if you
# use stat = "identity":
set.seed(1)
y <- rnorm(100)
df <- data.frame(
  x = 1,
  y0 = min(y),
  y25 = quantile(y, 0.25),
  y50 = median(y),
  y75 = quantile(y, 0.75),
  y100 = max(y)
)
ggplot(df, aes(x)) +
  geom_boxplot(
    aes(ymin = y0, lower = y25, middle = y50, upper = y75, ymax = y100),
    stat = "identity"
  )