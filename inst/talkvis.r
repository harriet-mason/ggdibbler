library(ggplot2)
library(dplyr)
library(ggthemes)
# Make data set

# Scatter plot
# Data
set.seed(7)
scatter_data <- data.frame(xmean = 1:5,
                           ymean = c(1.5, 2, 2.5, 3.5, 4.5),
                           xse = c(1.5, 2, 2, 3, 3),
                           yse = c(1, 0.5, 1, 1.5, 0.75)) |>
  mutate(xdist = distributional::dist_normal(xmean, xse),
         ydist = distributional::dist_normal(ymean, yse))

# ggplot
ggplot(data = scatter_data) + 
  geom_point(aes(x = xmean, y=ymean), colour="royalblue4", linewidth = 2)+
  labs(x = "X Estimate", y = "Y Estimate") +
  theme_few()

# ggdibber
ggplot(data = scatter_data) + 
  stat_sample(aes(xdist = xdist, ydist = ydist), 
              colour="royalblue1", size = 0.1, n=300)+
  labs(x = "X Estimate", y = "Y Estimate") +
  theme_few()


# Both
ggplot(data = scatter_data) + 
  stat_sample(aes(xdist = xdist, ydist = ydist), 
              colour="royalblue1", size = 0.1, n=300) + 
  geom_point(aes(x = xmean, y=ymean), colour="royalblue4", size = 2) +
  labs(x = "X Estimate", y = "Y Estimate") +
  theme_few()



# Density plot
# data
# Case 1 - High sample size
set.seed(1)
density_data <- data.frame(xmean = rnorm(15),
                           xse = rexp(15,3)) |>
  mutate(xdist = distributional::dist_normal(xmean, xse))


# ggplot of density
ggplot(data = density_data, aes(x=xmean)) +
  geom_density(colour="indianred4") +
  geom_rug(alpha=0.7, colour="indianred4") + 
  coord_cartesian(xlim =c(-3,3), ylim=c(0,0.7)) +
  labs(x = "X Estimate", y = "Density") +
  theme_few()


# ggdibbler
  # make data
fakedata <- sample_expand(data = density_data, times=100) |>
  select(-xdist) |>
  rename("xdist" = "x")

  # make plot
ggplot(data = fakedata, aes(x=xdist, group=distID)) +
  geom_density(linewidth = 0.1, colour="indianred1") +
  coord_cartesian(xlim =c(-3,3), ylim=c(0,0.7)) +
  labs(x = "X Estimate", y = "Density") +
  theme_few()


# Both

ggplot(data = fakedata, aes(x=xdist, group=distID)) +
  geom_density(colour="indianred1", linewidth = 0.1) +
  geom_density(data = density_data, aes(x=xmean), inherit.aes = FALSE,
               colour="indianred4", linewidth = 1.5)+
  coord_cartesian(xlim =c(-3,3), ylim=c(0,0.7)) +
  labs(x = "X Estimate", y = "Density") +
  theme_few()



# ggdist
library(ggdist)
ggplot(data = density_data) +
  stat_slab(aes(xdist = xdist, y=as.factor(xmean)), color = "indianred4", 
            fill = "indianred1", height =15, alpha=0.5) +
  coord_cartesian(xlim =c(-3,3))+
  labs(x = "X Estimate") +
  theme_ggdist() +
  theme(axis.text.y = element_blank(), axis.title.y = element_blank(),
        axis.line.y = element_blank())



