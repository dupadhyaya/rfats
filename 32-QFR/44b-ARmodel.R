# Auto Regressive Model

StockData = read.zoo("./32-QFR/DataChap4.csv",header = TRUE, sep = ",",format="%m/%d/%Y")
PriceData = ts(StockData$Adj.Close, frequency = 5)

PriceData

#No Differencing : 
diff(PriceData)

acf(PriceData, lag.max=15)
#acf decaying slowly

pacf(PriceData, lag.max=15)
#pacf cutting off after lag 1, so the 
#order of AR is 1

#if pacf cuts off after 2nd lag and acf is decaying slowly then the order of AR is 2 

#pacf cut off after 1 lag