#### TEST GGCHROMATIC THING
library(ggdibbler)
library(dplyr)
library(vctrs)
library(sf)
library(distributional)
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

################### MAKE BIVAR SCALE ########################

ggchromatic::cmyk_spec(0.1, 0.2, 0.3, 0)

# ggchromatic constructor
new_not <- function(...) {
  vals <- rlang::list2(...)
  missing <- vapply(vals, identical, logical(1), quote(expr = ))
  vals[missing] <- list(double())
  n <- lengths(vals)
  vals <- vec_recycle_common(!!!vals)
  new_rcrd(vals, class = "dibbler_bivar")
}

# Make bivar vector class
new_bivar <- function(...) {
  #if (!is.double(x)) {
  #  rlang::abort("`x` must be a double vector.")
  #}
  vctrs::new_rcrd(x, class = "dibbler_bivar")
}


# Make bivar stat
bivar <- function(x=new_dist()) {
  if (!is_distribution(x)) {
    rlang::abort("`x` must be a distribution vector.")
  }
  est <- sapply(x, distributional:::mean.distribution)
  se <- sapply(x, distributional::variance)
  print(mean)
  print(se)
  #x <- data.frame(mean = distributional:::mean.distribution(x), 
  #                se = distributional::variance(x))
  #x <- lapply(x, extrct_bivar)
  #x
  new_bivar(x)
}

extrct_bivar <- function(x) {
  # get mean and variance from distribution
  #x <- c(mean = distributional:::mean.distribution(x), se = distributional::variance(x))
  print(x)
  print(length(x))
  new_bivar(x)
}

is_bivar <- function(x) {
  inherits(x, "dibbler_bivar")
}

format.dibbler_bivar <- function(x, ...) {
  out <- lapply(vec_data(x), function(x) {
    return(signif(x, 2))
  })
  out <- lapply(out, format)
  out <- paste0("[", do.call(paste, c(out, sep = ",")), "]")
  out[is.na(x)] <- NA
  out
}

vec_ptype_abbr.dibbler_bivar <- function(x, ...) {
  "bivar"
}

vec_ptype2.dibbler_bivar.dibbler_bivar <- function(x, y, ...) new_bivar()

vec_ptype2.dibbler_bivar.double <- function(x, y, ...) double()

vec_ptype2.double.dibbler_bivar <- function(x, y, ...) double()

vec_cast.dibbler_bivar.dibbler_bivar <- function(x, to, ...) x

vec_cast.dibbler_bivar.double <- function(x, to, ...) bivar(x)
vec_cast.double.dibbler_bivar <- function(x, to, ...) vec_data(x)

vec_cast.dibbler_bivar.distribution <- function(x, to, ...) bivar(x)
vec_cast.distribution.dibbler_bivar <- function(x, to, ...) dist_normal(x)


as_bivar <- function(x) {
  vec_cast(x, new_bivar())
}


# checking code
x <- toy_temp_dist$temp_dist
x <- bivar(x)
x

vec_cast(x, bivar())

tibble::tibble(x)

vec_ptype2(bivar(), bivar())