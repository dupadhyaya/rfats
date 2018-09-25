library('quantmod')
#Calling the Quantmod library. 

library(quantmod)
getSymbols(c("SUNPHARMA.BO","CIPLA.BO"))
#Retrieving data for SunPharma and Cipla stocks from Yahoo API.

chartSeries(c(CIPLA.BO, SUNPHARMA.BO), subset='last 3 months')
#Plotting last 3 months data. Change the timeframe to your choice.

addBBands()
addROC()
#plotting Bollinder Bands and Rate of Change here. 

#https://github.com/kedar123pro/R-Quantmod-Demo

