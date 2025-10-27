
# make data smaller because otherwise there is no uncertainty
set.seed(248)
index <- sample(nrow(uncertain_diamonds), size = 1000)
smaller_diamonds <- diamonds[index,]
smaller_uncertain_diamonds <- uncertain_diamonds[index,]

# GGPLOT
ggplot(smaller_diamonds, aes(carat)) +
  geom_density()
# GGDIBBLER
ggplot(smaller_uncertain_diamonds, aes(carat)) +
  geom_density_sample(size=0.2)

# ORIENTATION FLIP RETURNS AN ERROR
# GGPLOT
ggplot(diamonds, aes(y = carat)) +
  geom_density()
# GGDIBBLER
ggplot(uncertain_diamonds, aes(y = carat)) +
  geom_density_sample()

# DONT ACCEPT ADJUST PARAMETER
ggplot(diamonds, aes(carat)) +
  geom_density(adjust = 1/5)
ggplot(uncertain_diamonds, aes(carat)) +
  geom_density_sample(adjust = 1/5)

