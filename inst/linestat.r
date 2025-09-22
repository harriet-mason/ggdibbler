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




