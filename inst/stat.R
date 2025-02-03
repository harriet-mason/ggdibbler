# working out inputs and outputs
library(ggplot2)
library(distributional)
devtools::load_all()

# look at what ggplot object is
t <- toymap
a <- ggplot(t)
b <- ggplot(t, aes(x=temp, y=se))

# nevermind, turns out I have to use ggproto, I need to read advanced section of ggplot2 book
