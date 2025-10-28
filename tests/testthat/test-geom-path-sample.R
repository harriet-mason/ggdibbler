library(vdiffr)
test_that("geom_line_sample tests", {
  # no random variables used - just return normal points
  set.seed(24)
  # deterministic tests
  p1 <- ggplot(economics, aes(date, unemploy)) + 
    geom_line_sample()
  expect_doppelganger("example1", p1)
  
  p2 <- ggplot(economics, aes(date, unemploy)) + 
    geom_step_sample()
  expect_doppelganger("example2", p2)
  
  p3 <- ggplot(economics, aes(date, unemploy)) + 
    geom_path_sample()
  expect_doppelganger("example3", p3)
  
  p4 <- ggplot(uncertain_economics, aes(date, unemploy)) + 
    geom_line_sample(alpha=0.1) 
  expect_doppelganger("example4", p4)
  
  p5 <- ggplot(uncertain_economics, aes(unemploy, date)) + 
    geom_line_sample(orientation = "y", alpha=0.1)
  expect_doppelganger("example5", p5)
  
  uncertain_recent <- uncertain_economics[uncertain_economics$date > as.Date("2013-01-01"), ]
  
  p6 <- ggplot(uncertain_recent, aes(date, unemploy)) + 
    geom_line_sample(alpha=0.3) #ggdibbler
  expect_doppelganger("example6", p6)
  
  p7 <- ggplot(uncertain_recent, aes(date, unemploy)) + 
    geom_step_sample(alpha=0.3) #ggdibbler
  expect_doppelganger("example7", p7)
  
  p8 <- ggplot(uncertain_economics, aes(date, unemploy)) +
    geom_line_sample(colour = "red", alpha=0.1)
  expect_doppelganger("example8", p8)
  
  p9 <- ggplot(uncertain_economics, aes(x = date, y = pop)) + 
    geom_line_sample(arrow = arrow(), alpha=0.1)
  expect_doppelganger("example9", p9)
  
  p10 <- ggplot(uncertain_economics, aes(x = date, y = pop)) +
    geom_line_sample(arrow = arrow(angle = 15, ends = "both", type = "closed"),
                     alpha=0.1)
  expect_doppelganger("example10", p10)
  
}
)

# ####################### PASS #################

# ####################### FAIL #################
# 
# # separate by colour and use "timeseries" legend key glyph
# ggplot(economics_long, aes(date, value01, colour = variable)) +
#   geom_line(key_glyph = "timeseries")
# ggplot(uncertain_economics_long, aes(date, value, colour = variable)) +
#   geom_line_sample(key_glyph = "timeseries", times=1)
# ggplot(uncertain_economics_long, aes(date, value, colour = variable)) +
#   geom_line_sample(key_glyph = "timeseries", times=2) #????
# 
# # geom_path lets you explore how two variables are related over time,
# # e.g. unemployment and personal savings rate
# # ggplot
# m <- ggplot(economics, aes(unemploy/pop, psavert))
# m + geom_path()
# m + geom_path(aes(colour = as.numeric(date)))
# # ggdibbler
# n <- ggplot(uncertain_economics, aes(unemploy/pop, psavert))
# n + geom_path_sample()
# n  + geom_path_sample(aes(colour = as.numeric(date)))
# 
# # ####################### UNTESTED #################
# 
# # Control line join parameters
# df <- data.frame(x = 1:3, y = c(4, 1, 9))
# base <- ggplot(df, aes(x, y))
# base + geom_path(linewidth = 10)
# base + geom_path(linewidth = 10, lineend = "round")
# base + geom_path(linewidth = 10, linejoin = "mitre", lineend = "butt")
# 
# # You can use NAs to break the line.
# df <- data.frame(x = 1:5, y = c(1, 2, NA, 4, 5))
# ggplot(df, aes(x, y)) + geom_point() + geom_line()
# 
# # Setting line type vs colour/size
# # Line type needs to be applied to a line as a whole, so it can
# # not be used with colour or size that vary across a line
# x <- seq(0.01, .99, length.out = 100)
# df <- data.frame(
#   x = rep(x, 2),
#   y = c(qlogis(x), 2 * qlogis(x)),
#   group = rep(c("a","b"),
#               each = 100)
# )
# p <- ggplot(df, aes(x=x, y=y, group=group))
# # These work
# p + geom_line(linetype = 2)
# p + geom_line(aes(colour = group), linetype = 2)
# p + geom_line(aes(colour = x))
# # But this doesn't
# should_stop(p + geom_line(aes(colour = x), linetype=2))
