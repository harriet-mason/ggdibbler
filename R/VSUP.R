# temporary test data
estimates <- toymap$temp
stderrs <- toymap$se
colourvalues <- colorspace::sequential_hcl(4, palette = "YlOrRd")


# desaturation, lightening, transparency functions
# input: colour=palette, levels = # saturations, type = how to add uncertainty
bivariate_pal <- function(colours, type,  n=4, amount=1){
  # value can be total change OR vector of increments
  if (length(amount)==1) {
    sups <- seq(from = 0, to=amount, length.out = n)[-1]
  } else {
    sups <- amount
  }
  # make palette
  pal <- colours
  
  # adjust for each value
  for(i in sups){
    # adjust colour based on function
    if (type == "desaturate") {
      colours <- colorspace::desaturate(colours, amount=i)
    } else if (type == "lighten") {
      colours <- colorspace::lighten(colours, amount=i)
    } else if (type == "transparency") {
      colours <- colorspace::adjust_transparency(colours, alpha=1-i)
    } else {
      stop("Visual channel for palette adjustment not recognised")
    }
    
    # set palette
    pal <- c(pal, colours)
  }
  pal
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
