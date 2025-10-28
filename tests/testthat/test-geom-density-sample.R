
# make data smaller because otherwise there is no uncertainty and takes too long
set.seed(248)
index <- sample(nrow(uncertain_diamonds), size = 100)
smaller_diamonds <- diamonds[index,]
smaller_uncertain_diamonds <- uncertain_diamonds[index,]

####################### PASS #################

# GGPLOT
ggplot(smaller_diamonds, aes(carat)) +
  geom_density()
# GGDIBBLER
ggplot(smaller_uncertain_diamonds, aes(carat)) +
  geom_density_sample(size=0.2)

# GGPLOT
ggplot(smaller_diamonds, aes(y = carat)) +
  geom_density()
# GGDIBBLER
ggplot(smaller_uncertain_diamonds, aes(y = carat)) +
  geom_density_sample()

# ACCEPTS ADJUST PARAMETER BUT DOESN'T DO ANYTHING
ggplot(smaller_diamonds, aes(carat)) +
  geom_density(adjust = 1/5)
ggplot(smaller_uncertain_diamonds, aes(carat)) +
  geom_density_sample(adjust = 1/5)

####################### FAIL #################


# INTERACTING THE DRAWS WITH THE GROUPS SEEMS TO CREATE ISSUES HERE
# MIGHT BE ABLE TO TWEAK RATHER THAN FIND NEW SOLUTION
# DON'T LOOK CLOSE TO THE SAME, RIP
ggplot(smaller_diamonds, aes(carat, after_stat(count), fill = cut)) +
  geom_density(position = "stack") #ggplot
ggplot(smaller_uncertain_diamonds, aes(carat, after_stat(count), fill = cut)) +
  geom_density_sample(position = "stack", times=100) #ggdibbler

# SAME ISSUE
# XLIM ALSO DEOSN'T WORK
# ggplot
ggplot(smaller_diamonds, aes(depth, colour = cut)) +
  geom_density() +
  xlim(55, 70)
# ggdibbler
ggplot(smaller_uncertain_diamonds, aes(depth, colour = cut)) +
  geom_density_sample() +
  xlim(55, 70)

# SAME ISSUE
ggplot(smaller_diamonds, aes(depth, fill = cut, colour = cut)) +
  geom_density(alpha = 0.1) +
  xlim(55, 70)
ggplot(smaller_uncertain_diamonds, aes(depth, fill = cut, colour = cut)) +
  geom_density_sample(alpha = 0.1) +
  xlim(55, 70)

# SAME ISSUE
# You can use position="fill" to produce a conditional density estimate
ggplot(smaller_diamonds, aes(carat, after_stat(count), fill = cut)) +
  geom_density(position = "fill")
ggplot(smaller_uncertain_diamonds, aes(carat, after_stat(count), fill = cut)) +
  geom_density_sample(position = "fill")


# WARNING "vec_proxy_compare.distribution() not supported."
# Loses marginal densities
ggplot(smaller_diamonds, aes(carat, fill = cut)) +
  geom_density(position = "stack")
ggplot(smaller_uncertain_diamonds, aes(carat, fill = cut)) +
  geom_density(position = "stack")


# WARNING "Ignoring unknown parameters: `bounds`"
# Use `bounds` to adjust computation for known data limits
big_diamonds <- smaller_diamonds[smaller_diamonds$carat >= 1, ]
big_uncertain_diamonds <- smaller_uncertain_diamonds[smaller_diamonds$carat >= 1, ]
ggplot(big_diamonds, aes(carat)) +
  geom_density(color = 'red') +
  geom_density(bounds = c(1, Inf), color = 'blue')
ggplot(big_uncertain_diamonds, aes(carat)) +
  geom_density_sample(color = 'red') +
  geom_density_sample(bounds = c(1, Inf), color = 'blue')

####################### UNTESTED #################






