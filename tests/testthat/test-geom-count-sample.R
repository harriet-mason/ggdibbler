
# THIS CODE FROM EXAMPLE RETURNS ERROR 
# LIKELY DUE TO CATEGORICAL MAPPED TO POSITION
# GGPLOT
d <- ggplot(diamonds, aes(x = cut, y = clarity))
d + geom_count(aes(size = after_stat(prop)))
# GGDIBBLER
d <- ggplot(uncertain_diamonds, aes(x = cut, y = clarity))
d + geom_count_sample(aes(size = after_stat(prop)), times=1, alpha=0.1)


# THIS PLOT GIVES WEIGHT WARNING MESSAGE
# GGPLOT
ggplot(mpg, aes(cty, hwy)) +
  geom_count()
# GGDIBBLER
ggplot(uncertain_mpg, aes(cty, hwy)) +
  geom_count_sample(alpha=0.2) 

