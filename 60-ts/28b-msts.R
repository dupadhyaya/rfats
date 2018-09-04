# Freq 
#package msts

library(forecast)
#An alter­na­tive is to use a msts object (defined in the forecast pack­age) which han­dles mul­ti­ple sea­son­al­ity time series. Then you can spec­ify all the fre­quen­cies that might be rel­e­vant. It is also flex­i­ble enough to han­dle non-integer frequencies.

data
taylor <- msts(data, seasonal.periods=c(48,336))
taylor               
taylor.fit <- tbats(taylor)
plot(forecast(taylor.fit))
