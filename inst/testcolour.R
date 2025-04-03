#### TEST GGCHROMATIC THING
library(ggchromatic)
library(ggdibbler)

# Mean data
toy_temp_est <- toy_temp |> 
  group_by(county_name) |>
  summarise(temp_mean = mean(recorded_temp),
            temp_se = sd(recorded_temp)/sqrt(n())) 

# Plot Mean Data
ggplot(toy_temp_est) +
  geom_sf(aes(geometry=county_geometry, 
              fill=hsl_spec(h=temp_mean, s=temp_se, l=0.5)))

ggplot(economics, aes(date, unemploy)) +
  geom_point(aes(colour = hcl_spec(pop, psavert)))
