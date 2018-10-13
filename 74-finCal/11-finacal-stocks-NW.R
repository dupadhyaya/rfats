library(FinCal)

get.ohlc.google(symbol="AAPL")
get.ohlc.google(symbol="AAPL")
get.ohlc.google(symbol="AAPL",start="2013-08-01")
get.ohlc.google(symbol="AAPL",start="2013-07-01",end="2013-08-01")
apple <- get.ohlc.yahoo(symbol = "AAPL", start = "2013-07-01", end = "2013-08-01")
#Example 25 Download historical ﬁnancial data from Yahoo finance and Google Finance
#Download historical ﬁnancial data from Yahoo finance
get.ohlc.yahoo(symbol = "AAPL", start = "firstDay", end = "today", freq = "d")
apple <- get.ohlc.yahoo(symbol = "AAPL", start = "2013-07-01", end = "2013-08-01")
head(apple)
all <- get.ohlcs.google(symbols = c("YHOO", "SPY", "SINA"), start = "2013-01-01", end = "2013-07-31")
head(all$YHOO)

Example 26 Plots open-high-low-close chart of (ﬁnancial) time series.
Line chart

apple <- get.ohlc.yahoo(symbol = "AAPL", start = "2013-07-01", end = "2013-08-01")

google <- get.ohlc.yahoo("GOOG", start = "2013-07-01", end = "2013-08-01")
candlestickChart(google)
apple <- get.ohlc.google("AAPL")
volumeChart(apple)

lineChart(apple)

























#Not Working
library(quantmod)
getSymbols("GOOG", start = "2013-07-01", end = "2013-08-01")
head(GOOG)
volumeChart(GOOG$GOOG.Volume)
candlestickChart(GOOG)
