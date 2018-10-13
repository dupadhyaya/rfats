# Load up a few libraries we'll need to retrieve and work with the data
library(highcharter)
library(googleAnalyticsR)
library(forecast)

# Set the view ID that we'll be using. You can get the view ID for a specific view# that you have access to by logging into the Google Analytics Query Explorer at
# https://ga-dev-tools.appspot.com/query-explorer/. It's the "ids" value.
view_id <- 81416156

# Authorize Google Analytics
ga_auth()

# Get the data from Google Analytics
gadata <- google_analytics_4(view_id,      date_range = c("2013-08-01", "2016-07-31"),   metrics = "sessions", dimensions = c("yearMonth"),   max = -1)

# Convert the data to be officially "time-series" data
ga_ts <- ts(gadata$sessions, start = c(2013,08), end = c(2016,07), frequency = 12)

# Compute the Holt-Winters filtering for the data
forecast1 <- HoltWinters(ga_ts)

# Generate a forecast for next 12 months of the blog sessions
hchart(forecast(forecast1, h = 12))