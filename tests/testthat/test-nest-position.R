library(ggplot2)
position_by_group(mpg, "model")


mpg_test <- sample_expand(uncertain_mpg, 5)
position_by_group(mpg_test, "drawID", PositionDodgeIdentity$compute_group)
