# example code from fable that uses distributional
# from fable readme https://github.com/tidyverts/fable/tree/main
library(fable)
library(tsibble)
library(tsibbledata)
library(lubridate)
library(dplyr)
example_data <- aus_retail %>%
  filter(
    State %in% c("New South Wales", "Victoria"),
    Industry == "Department stores"
  ) %>% 
  model(
    ets = ETS(box_cox(Turnover, 0.3)),
    arima = ARIMA(log(Turnover)),
    snaive = SNAIVE(Turnover)
  ) %>%
  forecast(h = "2 years") 

# default plot
example_data %>% 
  autoplot(filter(aus_retail, year(Month) > 2010), level = NULL)

# from vignette
tourism_melb <- tourism %>%
  filter(Region == "Melbourne")

fit <- tourism_melb %>%
  model(
    ets = ETS(Trips ~ trend("A")),
    arima = ARIMA(Trips)
  )

# This forecast doesnt have the time wrap???
fc <- fit %>%
  forecast(h = "5 years")

# default plot
fc %>%
  autoplot(tourism_melb)


# Also look at bootstrapped example from forecast textbook
# https://otexts.com/fpp3/prediction-intervals.html
library(fpp3)

google_2015 <- gafa_stock |>
  filter(Symbol == "GOOG", year(Date) >= 2015) |>
  mutate(day = row_number()) |>
  update_tsibble(index = day, regular = TRUE) |>
  filter(year(Date) == 2015)

fit <- google_2015 |>
  model(NAIVE(Close))

fc <- fit |> forecast(h = 30, times=10, bootstrap = TRUE)

# default plot
autoplot(fc, google_2015)

# Using generate to get actual outcomes
sim <- google_2015 |>
  model(NAIVE(Close)) |> 
  generate(h = 30, times = 30, bootstrap = TRUE)

google_2015 |>
  ggplot(aes(x = day)) +
  geom_line(aes(y = Close)) +
  geom_line(aes(y = .sim, group = as.factor(.rep)),
            colour="blue", data = sim, alpha=0.7) +
  labs(title="Google daily closing stock price", y="$US" ) +
  guides(colour = "none")

# Work With...
    # bootstrapped data
    # distribution

# check family
all(family(fc$Close)=="sample")
# line to include to check family in stat
families <- distcols[sapply(distcols, family)]
#get sample in sample dist
parameters(Close)

# methods pass to distributional:::dist_apply, just check that function
x <- fc$Close
# check all lines of dist_apply to work out what happens

dog <- distributional:::dist_apply(x, parameters)

# top level object is a distribution and calls f.distribution (e.g. mean.distribution)
# 2nd level object is a sample f.dist_sample (e.g. mean.dist_sample) and calculates with mean(x$x)
# must be accessing the sample??