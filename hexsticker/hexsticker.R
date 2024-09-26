library(hexSticker)

imgurl <- "hexsticker/enclosure.png"

s <- sticker(imgurl, package="ggdibbler", p_size=0, 
             h_fill="white",h_color="black", 
             s_x=1.075, s_y=0.975, s_width = 1.3, 
             filename="hexfile.png", dpi = 600)

plot(s)

usethis::use_logo("hexfile.png")
