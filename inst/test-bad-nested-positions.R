# DEBUGGING CODE
#trace(what = colSums, tracer = browser)
#untrace(colSums)

# load library
library(ggplot2)

# get stacked plots
source("inst/bad-nested-positions.R")

# base ggplot
g <- ggplot(mpg, aes(class)) #ggplot



# MAIN IS IDENTITY
g + geom_bar(aes(fill = drv), position="identity", alpha=0.7)

set.seed(3)
ggplot(uncertain_mpg, aes(class)) +
  geom_bar_sample(aes(fill = drv), position = "identity_stack", alpha=0.7)




# MAIN IS DODGE
g + geom_bar(aes(fill = drv), position=position_dodge(preserve = "single"))

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_stack")


# MAIN IS STACK
g + geom_bar(aes(fill = drv), position="stack")

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack")

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_identity", alpha=0.1)

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_identity", alpha=0.05, times=30)

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
   geom_bar_sample(aes(fill = drv), position = "stack_stack1", alpha=0.1, times=30)
set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_stack2", alpha=0.1, times=30)

# check when functions not printing
# set.seed(3)
# ggplot(uncertain_mpg, aes(class)) + 
#   geom_bar_sample(aes(fill = drv), position = "identity_dodge", alpha=0.1)
# 
# set.seed(3)
# ggplot(uncertain_mpg, aes(class)) + 
#   geom_bar_sample(aes(fill = drv), position = position_nest("identity_dodge"))


