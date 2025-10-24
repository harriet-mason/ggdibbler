ggplot(mpg, aes(cty, hwy)) +
  geom_point()

test <- uncertain_mpg
test$cyl_det <- mpg$cyl

ggplot(mpg, aes(cty, hwy)) +
  geom_count(alpha=0.5) 

ggplot(uncertain_mpg, aes(cty, hwy, group=cyl)) +
  geom_point_sample(alpha=0.5)

ggplot(mpg, aes(cty, hwy, group=cyl)) +
  geom_count_sample(alpha=0.5) 

ggplot(test, aes(cty, hwy)) +
  geom_count_sample(alpha=0.05, times=30)


ggplot(mpg, aes(cty, hwy)) +
  geom_count()
mpg$cty
mpg$hwy


df <- data.frame(x = dist_binomial(size = 1:5, prob = c(0.05, 0.5, 0.3, 0.9, 0.1)),
                 y = dist_binomial(size = 3:7, prob = c(0.1, 0.5, 0.7, 0.9, 0.1)))
ggplot(df, aes(x, y)) +
  geom_count_sample()

# CHECK WHAT HAPPENS TO GEOM_POINT (OR ANY STAT-SAMPLE) DATA WHEN GROUPING HAPPENS & REPLICATE


