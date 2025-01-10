#' Generates a bivariate palette
#' 
#' This function creates a bivariate palette, so that the previously 1D colour palette can become 2D, which allows variance to be mapped.
#'
#' @param colours character vector (of length d) of hex colours.
#' @param type a character to highlight how the values will be transformed between layers of the palette. Can be one of "desaturate", "lighten", or "transparency". Is set to "desaturate" by default.
#' @param n  an integer representing the number of times the base colours should be transformed. I.e. the depth of the bivariate palette.
#' @param amount an integer representing the amount of desaturation, lightening, or transparency between the base colour and the final colour in the palette (with 1 being completely desaturated). Can also be a numeric vector of length n that provides the amount of desaturation occuring at each layer.
#'
#' @return A character vector representing the n*d colours in the bivariate palette
#'
#' @examples
#' colourvalues <- colorspace::sequential_hcl(4, palette = "YlOrRd")
#' pal_bivariate(colourvalues)
#'
#' @export
pal_bivariate <- function(colours, type="desaturate",  n=4, amount=1){
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

#' Generates a VSUP palette
#' 
#' This function creates a value supressed uncertainty palette so that a 1D colour palette can be transformed into a 2D palette that allows variance to be mapped to an axis. Unlike the bivariate palette, this palette merges values.
#'
#' @param colours character vector (of length d) of Hex colours.
#' @param method the mixing method used to combine colour values. Can be set to either "tree" (for the binary tree mix) or "shrinkage" to have a shrinkage mix. By default it is set to "tree".
#' @param type a character to highlight how the values will be transformed between layers of the palette. Can be one of "desaturate", "lighten", or "transparency". Is set to "desaturate" by default.
#' @param n  an integer representing the number of times the base colours should be transformed and mixed. I.e. the depth of the palette.
#' @param amount an integer representing the amount of desaturation, lightening, or transparency between the base colour and the final colour in the palette (with 1 being completely desaturated). Can also be a numeric vector of length n that provides the amount of desaturation occuring at each layer.
#'
#' @return A character vector representing the n*d colours in the value supressed uncertainty palette. 
#'
#' @examples
#' colourvalues <- colorspace::sequential_hcl(4, palette = "YlOrRd")
#' pal_vsup(colourvalues)
#'
#' @export
pal_vsup <- function(colours, method="tree", type="desaturate", n=NULL,  amount=1) {
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

