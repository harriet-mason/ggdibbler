
# Fill based StatMeanVar (cant check without propper ggplot)
StatMeanVar <- ggplot2::ggproto("StatMeanVar", ggplot2::Stat, 
                                compute_group = function(data, scales) {
                                  data$mfill <- distributional:::mean.distribution(data$fill)
                                  data$vfill <- distributional:::variance.distribution(data$fill)
                                  data
                                },
                                required_aes = c("fill")
)
# tested compute_group function and it works. Cant check the rest until fill is done
