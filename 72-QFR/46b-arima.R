#ARIMA Modeling

#auto regressive integrated moving avg models
#Arima(p,d,q)
#p - order of AR : acf and pacf
#d - order reqd to make series stationary
#q - order of MA : 

StockData = read.zoo("./32-QFR/DataChap4.csv",header = TRUE, sep = ",",format="%m/%d/%Y")
PriceData = ts(StockData$Adj.Close, frequency = 5)

PriceData
plot(PriceData)
#non-stationary : make it stationary
PriceDiff = diff(PriceData, differences = 1)
plot(PriceDiff)
#Stationary - mean, sd, var remains same all through the ranges
#constant across time.
d=1

#understand this ?????
#now calc p from pacf
pacf(PriceDiff, lag.max=10)
p=0
#reverse before lag 1

#now calc  from acf
acf(PriceDiff, lag.max=10)
q=1

#Arima model (0,1,1)
PriceArima = arima(PriceData, order=c(0,1,1))
PriceArima


#forecast
library(forecast)
FutureForecast = forecast(PriceArima, h=5)
FutureForecast

plot(FutureForecast)

#Model Adequacy for auto correlation
Box.test(FutureForecast$residuals, lag=20, type='Ljung-Box')
#pvalue > .05 : No significant auto correlation in residuals at lags 1-20
