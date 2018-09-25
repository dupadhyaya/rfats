#Moving Average Model MA
#do not take past values into account

#consider MA of the past few forecast error

StockData = read.zoo("./32-QFR/DataChap4.csv",header = TRUE, sep = ",",format="%m/%d/%Y")

VolumeData = ts(StockData$Volume, frequency = 5)

acf(VolumeData, lag.max=10)
#acf cuts sharply after lag1 
#ma order is 1

pacf(VolumeData, lag.max=10)
