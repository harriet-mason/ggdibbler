
library(tidyverse)

set.seed(1)

# randomly generate data with a random error
estimate_data <- tibble(xmean = rnorm(50),
                            xse = rep(0.5, 50))|>
  mutate(xdist = distributional::dist_normal(xmean, xse))


# ggdibbler of density
ggplot(data = estimate_data) +
  stat_sample_density(aes(x=xdist), times=3) 


expanded_data <- estimate_data |>
  # ggdibbler internal sample_expand
  ggdibbler:::sample_expand(times=1) |>
  select(-c(xmean, xse)) 

# ggplot ungrouped code
ggplot(data = expanded_data, aes(x=x)) +
  geom_density(linewidth = 0.1, colour="indianred1") +
  coord_cartesian(xlim =c(-3,3), ylim=c(0,0.7)) 

# ggplot grouped code 
ggplot(data = expanded_data, aes(x=x)) +
  geom_density(linewidth = 0.1, colour="indianred1", aes(group=drawID)) +
  coord_cartesian(xlim =c(-3,3), ylim=c(0,0.7)) 


