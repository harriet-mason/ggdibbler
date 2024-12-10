# temporary test data
colourvalues <- colorspace::sequential_hcl(4, palette = "YlOrRd")


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
  # the colourspace one throws a warning messes up if you have convex colours, something I fixed for the the ARSA function
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
      pal <- c(pal, rep(colourspace::hex(colour), 2*n/m)) #keep output same length as input
      }
  # if odd # of colours
    } else {
      stop("The tree VSUP requires an even number of unique colours for the palette to work. You have either supplied an odd number of colours, or you have duplicates in your palette")
    } 
  pal
}

shrinkage_mix <- function(colours, colour_mean, alpha){
  # alpha = b/a+b where b=est_var and a=global_var
  # mixing is only for adjustment on mean, not on the variance adjustment
  n <- length(colours)
  # convert to RGB for mixing
  colour_mean <- colorspace::hex2RGB(colour_mean)
  colours <- colorspace::hex2RGB(colours) 
  pal <- NULL 
  for(i in seq(n)){
    colour <- colorspace::mixcolor(alpha, colour_mean, colours[i])
    pal <- c(pal, colorspace::hex(colour))
  }
  pal
}
shrinkage_mix(colourvalues, mean_col, 0.25)

colourvaluesRGB <- colorspace::hex2RGB(colourvalues)
mean_col <- colorspace::hex(colorspace::mixcolor(0.5, colourvaluesRGB[2], colourvaluesRGB[3]))
scales::show_col(mean_col)
scales::show_col(colourvalues,ncol=4)
scales::show_col(shrinkage_mix(colourvalues, mean_col, 0.5),ncol=4)

perceptual_mix <- function(){
}

mix_colour <- function(colours, method="tree"){
  # adjust colour based on function
  if (method == "tree") {
    colours <- tree_mix(colours)
  } else if (method == "shrinkage") {
    colours <- shrinkage_mix(colours)
  } else if (method == "perceptual") {
    colours <- perceptual_mix(colours)
  } else {
    stop("The VSUP palette mixing method is not recognised. Please set method to tree, shrinkage, or perceptual.")
  }
  colours
}

VSUP <- function(colours, method="tree", n=NULL, amount) {
  if(is.null(n)){
    n = 1+ floor(log2(length(colours)))
  } 
  pal <- matrix(NA, nrow=n, ncol=length(colours))
  # use a set method
  if(class(method)=="character"){
    for(i in seq(n)){
      colours <- mix_colour(colours, method)
      pal[i] <- colours
    }
  } else if (class(method)=="function"){
    print("TODO: allow users to suppress with thier own function")
  }
}

VSUP(colourvalues)



mapply(colorspace::mixcolor, 0.5, rgb_colours[odd], rgb_colours[even])


