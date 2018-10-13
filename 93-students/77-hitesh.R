# Candlestick Diagrams

#this package is relevant but could not be used
install.packages("candlesticks", repos="http://R-Forge.R-project.org")

#http://www.onlinetradingconcepts.com/TechnicalAnalysis/Candlesticks/CandlestickBasics.html

data = read.csv('./data/candlestick1.csv', stringsAsFactors = F, colClasses = c('character',rep('numeric',4)))

#data = read.csv(file.choose())
str(data)
head(data)
as.Date('02-01-2007','%d-%m-%Y')

data$Date = as.Date(data$Date, format="%d-%m-%Y")
str(data)
range(data$Date)

#convert to TS
library(xts)

str(data)
#convert to multivariate TS
tsdata = xts(data[-1], order.by=data$Date )
str(tsdata)
head(tsdata)
#data ready for analysis
#check for missing values
tsdata[!complete.cases(tsdata),]
tsdata = tsdata[complete.cases(tsdata),]
sum(is.na(tsdata))

#
library(candlesticks)
library(quantmod)
has.OHLC(tsdata)
#testdata =na.omit(tsdata)[1:100]

#using quantmod
chart_Series(tsdata)

# create HLC relative to O
head(tsdata)
#tsdata2 = tsdata[FALSE,] #empty DF
tsdata$HO <- tsdata[,2]- tsdata[,1]
tsdata$LO <- tsdata[,3]- tsdata[,1]
tsdata$CO <- tsdata[,4]- tsdata[,1]
head(tsdata)

#Cluster packages
library(fpc)
library(cluster)
sum(is.na(tsdata))

# # K-Means Clustering with clusters based on HO, LO, CO

class_factors <- tsdata[, 5:7] # using H/O, L/O, C/O
set.seed(123)
head(class_factors)
fit <- kmeans(class_factors, 6)
fit$cluster
fit$centers
m <- fit$cluster # vector of the cluster assigned to each candle
head(m)

### which candles were classifed into each cluster?
cluster = as.xts(m)
head(cluster)
index(cluster) = index(tsdata) # coerce index of cluster series to match data's index
new_data = merge.xts(tsdata, cluster)
head(new_data)

chart_Series(new_data[1:100])
chart_Series(xts(coredata(new_data)[order(new_data$cluster),],type="candlesticks", order.by = index(new_data),  theme = chartTheme(up.col='black',up.col='green',dn.col='red')))
?chart_Series
#since data is large, reduce it to 100 rows and then see

data2 = new_data[1:100]
chart_Series(xts(coredata(data2)[order(data2$cluster),],type="candlesticks", order.by = index(data2),  theme = chartTheme(up.col='black',up.col='green',dn.col='red')))

#You need to interpret which type of candle represent type

#

#After this not done-----------------------------------
#1-Marubozu-----
help(CSPMarubozu)
#CSPMarubozu(tsdata, n=20, ATRFactor=1, maxuppershadowCL=.1, maxlowershadowCL=.1)
CSPMarubozu(testdata, n=20, ATRFactor=1, maxuppershadowCL=.1, maxlowershadowCL=.1)

#2-Dozi----

CSPDoji(testdata, maxbodyCL=.1, maxshadowCL=.1)

#3-Dragonfly Doji----

#4-Gravestone Doji----

#5-Spinning Top----
