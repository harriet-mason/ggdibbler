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

colourspace_blend <- function(colours){
  n <- length(colourvalues)
  if(n%%2 == 0){
    # if even # of colours
    odd <- seq(1, n, by=2)
    even <- seq(2, n, by=2)
    hcl_colours <- hex2hcl(colours)
    mapply(colorspace::mixcolor, colours[odd,], colours[even])

  }
  # if odd # of colours
  #colorspace::mixcolor()
}

# my colour blend function. The colourspace one messes up if you have convex colours, something I fixed for the
ARSA_blend <- function(basecols, p_length, nblend) {
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
# checks
scales::show_col(bivariate_pal(colourvalues, type = "dkwjend"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "desaturate"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "lighten"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "transparency"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "lighten", amount=c(0.1,0.2,0.3)), ncol=4)


# vsup
VSUP_pal <- function(colours, type,  n=4, amount=1){
  colorspace::mixcolor()
}
