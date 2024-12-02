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

tree_mix <- function(colours, amount=0.5){
  n <- length(colourvalues)
  # if even # of colours
  pal <- NULL
  if(n%%2 == 0){
    colours <- colorspace::hex2RGB(colours)
    for(i in seq(1, n, by=2)){
      colour <-colorspace::mixcolor(amount, rgb_colours[i], rgb_colours[i+1])
      pal <- c(pal, hex(colour)) #keep output same length as input
      }
  # if odd # of colours
    } else {
      stop("The tree VSUP requires an even number of colours in the palette to work")
    } 
  pal
}

VSUP <- function(colours, amount) {
  
}
  
  
rgb_colours <- colorspace::hex2RGB(colourvalues)
mixed <- tree_mix
scales::show_col(colourvalues,ncol=4)
scales::show_col(tree_mix(colourvalues),ncol=2)
tree_suppress(colourvalues)

mapply(colorspace::mixcolor, 0.5, rgb_colours[odd], rgb_colours[even])

# checks
scales::show_col(bivariate_pal(colourvalues, type = "dkwjend"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "desaturate"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "lighten"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "transparency"), ncol=4)
scales::show_col(bivariate_pal(colourvalues, type = "lighten", amount=c(0.1,0.2,0.3)), ncol=4)
