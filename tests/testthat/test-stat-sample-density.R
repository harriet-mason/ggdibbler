# putting the data in the ggplot layer breaks it. Will have to work through this with ggplot build
ggplot(data = density_data) +
  stat_sample_density(aes(x=x_dist))