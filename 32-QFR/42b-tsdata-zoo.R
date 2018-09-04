# Convert data into TS using zoo
#ts object has limitation in representing TS
#it is used for representing equally spaced data
#cannot be used Mon to Fri (Then gap of Sat & Sun or Holidays)

library(zoo)
52 * 5  #52 weeks and 5 days in each week
stockprice = round(runif(52*5, min=50, max=100),0)
stockprice

sp2 = zoo(stockprice)
sp2

dates = seq.Date(as.Date("2017-01-01"), as.Date("2017-12-31"),by=1)
dates2 <- as.POSIXlt(dates,format="%Y-%m-%d")
head(dates2)
dates2$wday  # 0 to 6

!(weekdays(as.Date(dates2)) %in% c('Saturday','Sunday'))
dates3= dates2[!(weekdays(as.Date(dates2)) %in% c('Saturday','Sunday'))]


sp3 = zoo(stockprice, order.by=dates3)
sp3
head(sp3, 10)
head(dates3$wday,10)

plot(sp3)
plot(sp3[1:50])

#https://stackoverflow.com/questions/6009351/removing-weekend-data-in-an-r-dataframe
