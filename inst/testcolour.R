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

################################################################

################### MAKE BIVAR SCALE ########################




# Make bivar vector class
new_bivar <- function(x=data.frame()) {
  if (!is.data.frame(x)) {
    rlang::abort("`x` must be a data.frame.")
  }
  vctrs::new_rcrd(x, class = "dibbler_bivar")
}

# Make bivar from distribution
bivar <- function(x=new_dist()) {
  if (!is_distribution(x)) {
    rlang::abort("`x` must be a distribution vector.")
  }
  # Convert distribution to mean/variance data frame
  x <- data.frame(
    est_mean = distributional:::mean.distribution(x),
    std_err = distributional::variance(x)
    )
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
z <- data.frame(
  est_mean = distributional:::mean.distribution(x),
  std_err = distributional::variance(x)
)
y <- bivar(x)


vec_cast(x, bivar())

tibble::tibble(y)

vec_ptype2(bivar(), bivar())