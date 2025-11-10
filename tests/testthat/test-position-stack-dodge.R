
g <- ggplot(mpg, aes(class)) #ggplot
g + geom_bar(aes(fill = drv))

g + geom_bar(aes(fill = drv), position = position_dodge(preserve = "single"))

library(ggplot2)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_dodge_identity(preserve = "single"), 
                    alpha=0.5)

set.seed(2)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_identity_dodge(preserve = "single"), 
                    alpha=0.5)

set.seed(2)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_stack_dodge(preserve = "single"), 
                    alpha=0.5)