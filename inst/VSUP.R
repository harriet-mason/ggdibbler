
# desaturation, lightening, transparency functions
# input: colour=palette, levels = # saturations, type = transform
transform_colour <- function(colours, type="desaturate", amount){
    # adjust colour based on function
  if (type == "desaturate") {
    colours <- colorspace::desaturate(colours, amount=amount)
    } else if (type == "lighten") {
      colours <- colorspace::lighten(colours, amount=amount)
      } else if (type == "transparency") {
        colours <- colorspace::adjust_transparency(colours, alpha=1-amount)
        } else {
          stop("Visual channel for palette adjustment not recognised")
          }
  colours
}

# saturation decrease function used in ARSA paper
ARSA_trans <- function(basecols, hue=1, sat=1, val=1) {
  X <- diag(c(hue, sat, val)) %*% rgb2hsv(col2rgb(basecols))
  hsv(pmin(X[1,], 1), pmin(X[2,], 1), pmin(X[3,], 1))
}

bivariate_pal <- function(colours, type="desaturate",  n=4, amount=1){
  # value can be total change OR vector of increments
  if (length(amount)==1) {
    sups <- seq(from = 0, to=1, length.out = n)[-1]
  } else {
    sups <- amount
  }
  # make palette
  pal <- colours
  
  # adjust for each value
  for(i in sups){
    colours <- transform_colour(colours, type, amount=i)
    pal <- c(pal, colours)
  }
  pal
}

hex2hcl <- function(colours){
  colours <- colorspace::hex2RGB(colours)
  as(colours, "polarLUV")
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

# all mix functions should return the same number of colours they spit out.
tree_mix <- function(colours, alpha=0.5){
  n <- length(colours)
  colours <- unique(colours)
  m <- length(colours)
  pal <- NULL #return full palette
  if(m==1){
    warning("Only one unique colour passed to the mixing function. Returning mixed colours that are the same as the original colour")
    pal <- rep(colours, n)
    return(pal)
  }
  # if even no. of colours
  if(m%%2 == 0){
    colours <- colorspace::hex2RGB(colours)
    for(i in seq(1, m, by=2)){
      colour <- colorspace::mixcolor(alpha, colours[i], colours[i+1])
      pal <- c(pal, rep(colorspace::hex(colour), 2*n/m)) #keep output same length as input
      }
  # if odd # of colours
    } else {
      stop("The tree VSUP requires an even number of unique colours for the palette to work. You have either supplied an odd number of colours, or you have duplicates in your palette")
    } 
  pal
}

shrinkage_mix <- function(colours, colour_mean=NULL, alpha=0.5){
  # get vector length
  n = length(colours)
  
  # convert to RGB for mixing
  colours <- colorspace::hex2RGB(colours) 
  
  # If mean colour not supplied, take middle value
  if (is.null(colour_mean)) {
    if(n%%2==0){
      colour_mean <- colorspace::mixcolor(0.5, colours[n/2], colours[(n/2)+1])
    } else {
      med <- (n+1)/2 
      colour_mean <- colorspace::hex2RGB(colours[med])
    }
  } else {
    colour_mean <- colorspace::hex2RGB(colour_mean)
  }
  
  # Set pal to fill in
  pal <- NULL 
  
  # keep in mind alpha = b/a+b where b=est_var and a=global_var
  for(i in seq(n)){
    colour <- colorspace::mixcolor(alpha, colour_mean, colours[i])
    pal <- c(pal, colorspace::hex(colour))
  }
  pal
}


mix_colour <- function(colours, method="tree"){
  # adjust colour based on function
  if (method == "tree") {
    colours <- tree_mix(colours)
  } else if (method == "shrinkage") {
    colours <- shrinkage_mix(colours)
  } else {
    stop("The VSUP palette mixing method is not recognised. Please set method to tree, shrinkage, or a function of your own.")
  }
  colours
}

value_sup_palette <- function(colours, method="tree", type="desaturate", n=NULL,  amount=1) {
  # set number of mixes in case of odd number
  if(is.null(n)){
    n = 1+ floor(log2(length(colours)))
  } 

  # value can be total change OR vector of increments
  if (length(amount)==1) {
    sups <- seq(from = 0, to=amount, length.out = n)[-1]
  } else if (length(ammount)==n){
    sups <- amount } else {
      stop(paste0("The colour transformation amount must be 1 or n (the number of times the colours are mixed. Amount has length ", 
      length(amount),  
      "While n is ",
      n))
    }

  # Set up matrix that will store colour names
  pal <- matrix(NA, nrow=n, ncol=length(colours))
  pal[1,] <- colours
  
  # iteratively transform then mix the colour palette n times
  if(class(method)=="character"){
    for(i in seq(n-1)){
      colours <- transform_colour(colours, type, amount=sups[i])
      colours <- mix_colour(colours, method)
      pal[i+1,] <- colours
    }
  } else if (class(method)=="function"){
    print("TODO: allow users to suppress with thier own function")
  }
  pal
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
colourvaluesRGB <- colorspace::hex2RGB(colourvalues)
mean_col <- colorspace::hex(colorspace::mixcolor(0.5, colourvaluesRGB[2], colourvaluesRGB[3]))
scales::show_col(mean_col)
scales::show_col(colourvalues,ncol=4)
scales::show_col(shrinkage_mix(colourvalues, mean_col, 0.5),ncol=4)
scales::show_col(t(VSUP(colourvalues, amount=0.8, method="shrinkage")))

