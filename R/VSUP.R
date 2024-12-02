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
