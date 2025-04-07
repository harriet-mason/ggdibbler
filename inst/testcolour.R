#### TEST GGCHROMATIC THING
library(ggdibbler)

######################### DATA STUFF ########################
# Mean data
toy_temp_est <- toy_temp |> 
  group_by(county_name) |>
  summarise(temp_mean = mean(recorded_temp),
            temp_se = sd(recorded_temp)/sqrt(n())) 

# Plot Mean Data
ggplot(toy_temp_est) +
  geom_sf(aes(geometry=county_geometry, 
              fill=hsl_spec(h=temp_mean, s=temp_se, l=0.5)))
################################################################


################### TEST GGCHROMATIC THING ########################
library(ggchromatic)

# Theoretically SHOULD work, does not
P <- ggplot(mtcars, aes(mpg, disp)) +
  geom_point(aes(colour = mpg))

rgb_palette(rgb_spec(1, 0, 0))

a <- hcl_spec(10:15, LETTERS[1:6], 12:7)
a
class(a)
b <- hcl_palette(a)
b
class(b)

##############################################

hsv_spec <- function(h = double(),
                     s = double(),
                     v = double()) {
  new_colour_spec(h = h, s = s, v = v, class = "hsv_spec")
}

hcl_spec(1,2,3)

hcl_spec <- function(h = double(),
                     c = double(),
                     l = double()) {
  new_colour_spec(h = h, c = c, l = l, class = "hcl_spec")
}

new_colour_spec <- function(..., class) {
  vals <- rlang::list2(1,2,3, "hsv_spec")
  missing <- vapply(vals, identical, logical(1), quote(expr = ))
  vals[missing] <- list(double())
  
  n <- lengths(vals)
  vals[n == 0] <- list(new_void_channel(max(n)))
  vals <- vctrs::vec_recycle_common(!!!vals)
  vctrs::new_rcrd(vals, class = c("colour_spec", class))
}

new_void_channel <- function(size = 0) {
  vctrs::new_vctr(rep(NA, size), class = "void_channel")
}

