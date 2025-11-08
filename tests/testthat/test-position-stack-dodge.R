
g <- ggplot(mpg, aes(class)) #ggplot
g + geom_bar(aes(fill = drv))

q <- ggplot(uncertain_mpg, aes(class))
q + geom_bar_sample(aes(fill = drv), position="stack_dodge")
