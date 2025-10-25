
# CARAT DISTRIBUTION LOOKS WEIRD
# GGPLOT
ggplot(diamonds, aes(carat)) +
  geom_density()
# GGDIBBLER
ggplot(uncertain_diamonds, aes(carat)) +
  geom_density_sample()

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

# FIX WEIRD LINE AT THE BOTTOM OF THE DISTRIBUTION
