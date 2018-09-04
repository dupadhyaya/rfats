# TS Linear Filters
#not working

library(zoo)
###Linear Filters
#https://www.packtpub.com/mapt/book/big_data_and_business_intelligence/9781786462411/4/ch04lvl1sec45/linear-filters


x = round(rnorm(100, mean=65, sd=10),0)
filter(x, filter=rep(1/5, 5))
?filter
tsx = ts(x)
tsx
class(tsx)
filter(tsx, filter=rep(1/5, 5))

(x <- 1:100)

filter(x, rep(1, 3))
filter(x, rep(1, 3), sides = 1)
filter(x, rep(1, 3), sides = 1, circular = TRUE)

filter(presidents, rep(1, 3))

#


StockData <- read.zoo("./32-QFR/DataChap4.csv",header = TRUE, sep = ",",format="%m/%d/%Y")
StockData
PriceData <- ts(StockData$Adj.Close, frequency = 5)
PriceData
?Filter
plot(PriceData,type="l")
WeeklyMAPrice <- filter(PriceData,stats::filter=rep(1/5,5))
monthlyMAPrice <- filter(PriceData,filter=rep(1/25,25))
lines(WeeklyMAPrice,col="red")
lines(monthlyMAPrice,col="blue")