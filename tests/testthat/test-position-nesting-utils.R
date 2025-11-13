
set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "stack_dodge")
set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_nest("stack_dodge"))

set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = "dodge_dodge")
set.seed(3)
ggplot(uncertain_mpg, aes(class)) + 
  geom_bar_sample(aes(fill = drv), position = position_nest("dodge_dodge"))

ggplot(mtcars, aes(am, vs)) +
  geom_point()
set.seed(3)
ggplot(mtcars, aes(am, vs)) +
  geom_point(position = "jitter")


set.seed(3)
ggplot(uncertain_mtcars, aes(am, vs)) +
  geom_point_sample()
generate(uncertain_mtcars$am,times=20)
generate(uncertain_mtcars$am,times=20)uncertain_mtcars$vs
ggplot(mtcars, aes(am, vs)) +
  geom_jitter(position = position_jitter(width = 0.1, height = 0.1))





