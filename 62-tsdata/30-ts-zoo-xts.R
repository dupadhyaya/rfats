#compare ts, zoo, xts

#create a vector
(sales = ceiling(runif(100,min=50,max=100)))

#ts object - monthly data
(ts1 = ts(sales, start=c(2010,1), freq=12))
#ts object - yearly data
(ts2 = ts(sales, start=c(2010,1), freq=1))
#ts object - daily data
(ts3 = ts(sales, start=c(2010,1), freq=365))

window(ts1, start=c(2010, 2), end=c(2010, 8))
index(ts2)



#zoo TS data : needs date (unique) index
library(zoo)
(dates1 = as.Date("2018-01-01") + 0:100)
range(dates1)

(zoo1 = zoo(sales, order.by = dates1))

summary(zoo1)
methods(class=zoo)

#these are functions of zoo: it coerces ts into zoo and use functions
rollmean(zoo1,k=2)
coredata(zoo1)
index(zoo1)

(monyr = timeDate::timeCalendar()) #get mon & yr of calendar yr
window(x=zoo1, start = as.Date("2018-02-01"), end = as.Date("2018-03-01"))

window(x=zoo1, index = dates1[c(4, 8, 10)])
#https://www.rdocumentation.org/packages/zoo/versions/1.8-3/topics/window.zoo

zoo1[format(index(zoo1), "%m")=="03"]

#xts

