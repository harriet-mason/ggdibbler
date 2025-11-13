
#trace(what = colSums, tracer = browser)
#untrace(colSums)

g <- ggplot(mpg, aes(class)) #ggplot

g + geom_bar(aes(fill = drv), position = position_dodge())

library(ggplot2)

# identity position
g + geom_bar(aes(fill = drv), position="identity", alpha=0.7)


set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "identity", alpha=0.25, times=2)

set.seed(3)
ggplot(uncertain_mpg, aes(class)) +
  geom_bar_sample(aes(fill = after_stat(drawID)), position = "identity", alpha=0.2, times=10,
                  colour="black")

func <- PositionIdentityStack$compute_panel
trace(what = ggplot2:::collide, tracer = browser)
set.seed(3)
ggplot(uncertain_mpg, aes(class)) +
  geom_bar_sample(aes(fill = drv), position = "identity_stack", alpha=0.2, times=2)
untrace(ggplot2:::collide)

trace(what = ggplot2:::collide, tracer = browser)
set.seed(3)
ggplot(uncertain_mpg, aes(class)) +
  geom_bar_sample(aes(fill = after_stat(drawID)), position = "identity_stack", alpha=0.2, times=10,
                  colour="black")
untrace(ggplot2:::collide)

trace(what = ggplot2:::collide, tracer = browser)
set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "identity_dodge", alpha=0.7)
untrace(ggplot2:::collide)

set.seed(3)
ggplot(uncertain_mpg, aes(class)) +
  geom_bar_sample(aes(fill = after_stat(drawID)), position = "identity_dodge", alpha=0.2, times=100)

# main plot dodge
g + geom_bar(aes(fill = drv), position=position_dodge(preserve = "single"))

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_identity", alpha=0.2)

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_dodge")


# set.seed(3)
# ggplot(uncertain_mpg, aes(class)) + 
#   geom_bar_sample(aes(fill = drv), position = "dodge_stack")

# main plot stack
g + geom_bar(aes(fill = drv), position="stack")

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_identity", alpha=0.2)

# set.seed(3)
# ggplot(uncertain_mpg, aes(class)) + 
#   geom_bar_sample(aes(fill = drv), position = "stack")
# 
# set.seed(3)
# ggplot(uncertain_mpg, aes(class)) + 
#   geom_bar_sample(aes(fill = drv), position = "stack_dodge")







# working case
set.seed(1)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_stack_dodge(), 
                  alpha=0.5, times=2)

# just stack
set.seed(2)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_stack_identity(), 
                  alpha=0.5, times=2)

# broken case
ggplot(uncertain_mpg, aes(x = class)) + 
  geom_bar_sample(aes(fill = drv), 
                  position = "stack_dodge")

ggplot(uncertain_mpg, aes(x = class)) + 
  geom_bar_sample(aes(fill = drv), 
                  alpha = 0.05, times = 30,
                  position = "stack_identity")




