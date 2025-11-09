
g <- ggplot(mpg, aes(class)) #ggplot
g + geom_bar(aes(fill = drv))

library(ggplot2)
q <- ggplot(uncertain_mpg, aes(class))
q + geom_bar_sample(aes(fill = drv), position="stack_dodge", alpha=0.5)
