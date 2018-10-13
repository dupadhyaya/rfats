# Air Passengers

data("AirPassengers")
class(AirPassengers)

tsData = AirPassengers

plot(AirPassengers)
#Multiplicative TS

logAP = log(AirPassengers)
plot(logAP)
#now additive

#is it stationary
library(tseries)
adf.test(tsData) # p-value < 0.05 indicates the TS is stationary
kpss.test(tsData)

# Seasonal Differencing
nsdiffs(tsData)  # number for seasonal differencing needed
tsData_seasdiff <- diff(tsData, lag=frequency(tsData), differences=1)  # seasonal differencing
tsData_seasdiff
plot(tsData_seasdiff, type="l", main="Seasonally Differenced")  # still not stationary!

# Make it stationary
ndiffs(tsData_seasdiff)  # number of differences need to make it stationary
#> 1 
tsData_seasdiff2 <- diff(tsData_seasdiff, differences= 1)
plot(tsData_seasdiff2, type="l", main="Differenced and Stationary")  # appears to be stationary

ndiffs(logAP)
ndiffs(AirPassengers)


#deTrend
tsData_deTrend <- lm(tsData ~ c(1:length(tsData)))
plot(resid(tsData_deTrend), type="l")  # resid(trModel) contains the de-trended series.



diffAP1 =diff(logAP)
plot(diffAP1)
#approx stationary now




# both acf() and pacf() generates plots by default
acfRes <- acf(tsData) # autocorrelation
pacfRes <- pacf(tsData)  # partial autocorrelation
ccfRes <- ccf(mdeaths, fdeaths, ylab = "cross-correlation") # computes cross correlation between 2 timeseries.
head(ccfRes[[1]])

#de-Trend and de-Seasonal
ts.stl = stl(AirPassengers,"periodic")
ts.sa = seasadj(ts.stl)  # de-seasonalize
ts.sa  #only trend, season removed
plot(AirPassengers, type="l")  # original series
plot(ts.sa, type="l")  # seasonal adjusted
seasonplot(ts.sa, 12, col=rainbow(12), year.labels=TRUE, main="Seasonal plot: Airpassengers") # seasonal frequency set as 12 for monthly data.
seasonplot(ts.sa, 12)


library(forecast)
auto.arima(diffAP1)


#---
laggedTS <- lag(tsData, 3) # shifted 3 periods earlier. Use `-3` to shift by 3 periods forward.
laggedTS

library(DataCombine)

myDf <- as.data.frame(tsData)
myDf

myDf <- slide(myDf, "x", NewVar = "xLag1", slideBy = -1)  # create lag1 variable
myDf

myDf <- slide(myDf, "x", NewVar = "xLead1", slideBy = 1)  # create lead1 variable
head(myDf)

library(seasonal)

s <- seas(tsData)
final(s)
head(ts.sa )
head(final(s))


tsData_forecast = HoltWinters(tsData)
HoltWinters(tsData, beta=FALSE, gamma=FALSE, l.start=23.56)
forecast.HoltWinters(tsData_forecasts, h=8)
forecast.


tsData_components = decompose(tsData)
(tsData_comp_seas = round(tsData_components$seasonal,2))
round(tsData_components$trend,2)
round(tsData_components$random,2)
plot(tsData_components)

(tsData_seas_adjusted = tsData - tsData_comp_seas)
head(tsData)
head(tsData_comp_seas)
plot(tsData_seas_adjusted)  #trend& irregular


#Exp Smoothening - no seasons
(tsData_ESS = HoltWinters(tsData, beta=F, gamma=F))
#0-least recent , 1-most recent
tsData_ESS$fitted
plot(tsData_ESS)
tsData_ESS$SSE
#forecast.HoltWinters(tsData_ESS, h=8)
tsData_ESS
forecast1 = forecast(tsData_ESS,3)
Box.test(forecast1$residuals, lag=20, type="Ljung-Box")
plot(forecast1$residuals)


#TS with trend and 
(tsData_ES2 <- HoltWinters(tsData, gamma=FALSE))
#level - recent, slope - old
plot(tsData_ES2)
head(tsData)
#start from 118, slope from 118-112=6
HoltWinters(tsData, gamma=FALSE, l.start=118, b.start=6)
p =predict(tsData_ES2, h=19)
plot(p)

tsData
tsclean(tsData)

ggplot2::autoplot(tsData)


decom_A = decompose(tsData,"additive")
autoplot(decom_A)


decom_M = decompose(tsData,"multiplicative")
autoplot(decom_M)

adf.test(tsData) 

autoplot(acf(tsData,plot=FALSE))
title(main="Correlogram of Air Passengers from 1949 to 1961")

library(ggplot2)

autoplot(tsData) + geom_smooth(method="lm")+ labs(x ="Date", y = "Passenger numbers (1000's)", title="Air Passengers from 1949 to 1961") 
