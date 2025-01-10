
# saturation decrease function used in ARSA paper
ARSA_trans <- function(basecols, hue=1, sat=1, val=1) {
  X <- diag(c(hue, sat, val)) %*% rgb2hsv(col2rgb(basecols))
  hsv(pmin(X[1,], 1), pmin(X[2,], 1), pmin(X[3,], 1))
}


# mixcolour function used in the ASRA paper
  # the colorspace one throws a warning messes up if you have convex colours, something I fixed for the the ARSA function
ARSA_mix <- function(basecols, p_length, nblend) {
  X <- rgb2hsv(col2rgb(unique(basecols)))
  v1 <- X[,seq(1,dim(X)[2], 2)]
  v2 <- X[,seq(2,dim(X)[2], 2)]
  if("matrix" %in% class(v1)){
    # hue issue wrap around pt 1
    v3 <- (v1+v2)
    v3["h",] <- ifelse(abs(v1["h",]-v2["h",])>0.5, v3["h",]+1, v3["h",])
    v3 <- v3/2
    # hue issue wrap around pt 2
    v3["h",] <- ifelse(v3["h",]>=1 , v3["h",]-1 ,v3["h",])
    hsv(rep(v3[1,], each=nblend), rep(v3[2,], each=nblend), rep(v3[3,], each=nblend))
  } else {
    v3 <- (v1+v2)
    v3["h"] <- ifelse(abs(v1["h"]-v2["h"])>0.5, v3["h"]+1, v3["h"])
    v3 <- v3/2
    v3["h"] <- ifelse(v3["h"]>=1 , v3["h"]-1 ,v3["h"])
    rep(hsv(h=v3[1], s=v3[2], v=v3[3]), p_length)
  }
}


# temporary test colours
colourvalues <- colorspace::sequential_hcl(4, palette = "YlOrRd")
vsup <- value_sup_palette(colourvalues, amount=0.8, method="shrinkage")
n <- dim(vsup)[2]
d <- dim(vsup)[1]
# Get toydata package from ggdibble
# devtools::load_all()
# toydata is weird so im getting it from the code ATM
#toydata <- toymap # delete when saved version is fine

vsup_scale_discrete <- function(distribution, n, m){
  # input is distribution vector and colour palette dimensions
  means <- mean(distribution) # get mean vector
  jumps <- (max(means) + 2 - min(means))/n
  mean_breaks <- c(seq(from=min(means), by=jumps, length = n+1)) 
  # if min and max are equal to cut, it 
  actual_breaks <- c(-Inf, mean_breaks[-(n-1)], Inf)
  print(actual_breaks)
  mean_breaks2 <- c(seq(to=max(means), by=jumps, length = n)) 
  mean_key <- cut(means, breaks = mean_breaks) # breaks remove max while labels add 0
  print(means)
  print(mean_key)
  #variances <- variance(distribution) # get mean vector
  #variance_breaks <- floor(seq(min(variances), max(variances)+1, length.out = m)) # palette breaks
  #variance_key <- cut(variances, breaks = variance_breaks[-n])
  #paste(mean_key, variance_key, sep="-")
}

vect_pal_trans(toymap$temp_dist, n, d)


library(distributional) # remove when I stop getting that error

test <- toymap |>
  dplyr::mutate(est = mean(temp_dist),
                vari = variance(temp_dist))

  pivot_longer(cols=highvar:lowvar, names_to = "variance_class", values_to = "variance") |>
  # add bivariate classes to data
  mutate(bitemp = cut(temp, breaks=breaks, labels=seq(8)),
         bivar = cut(variance, breaks=0:4, labels=seq(4)),
         biclass = paste(bitemp, bivar, sep="-"))|>
  mutate(highlight = ifelse(count_id <= 5, TRUE, FALSE))

# Bivariate maps
toymap |>
  ggplot() +
  geom_sf(aes(fill = , geometry = geometry), colour=NA) + 
  scale_fill_manual(values = bivariatepal) +
  theme_void() + 
  theme(legend.position = "none")

# VSUP maps
p3a <- my_map_data |>
  filter(variance_class=="lowvar") |>
  ggplot() +
  geom_sf(aes(fill = biclass, geometry = geometry), colour=NA) + 
  scale_fill_manual(values = VSUP) +
  theme_void() + 
  theme(legend.position = "none")

# VSUP geom_sf
# geom_sf_VSUP <- function(ggplot, ???){
#   ggplot +
#     geom_sf(aes(fill = ???, geometry = geometry), colour=NA) + 
#     scale_fill_manual(values = VSUP)
# }
# write up similarly to geom_sf but with VSUP


# testing lines
colourvalues <- colorspace::sequential_hcl(4, palette = "YlOrRd")

colourvaluesRGB <- colorspace::hex2RGB(colourvalues)
mean_col <- colorspace::hex(colorspace::mixcolor(0.5, colourvaluesRGB[2], colourvaluesRGB[3]))
scales::show_col(mean_col)
scales::show_col(colourvalues,ncol=4)
scales::show_col(shrinkage_mix(colourvalues, mean_col, 0.5),ncol=4)
scales::show_col(t(VSUP(colourvalues, amount=0.8, method="shrinkage")))

