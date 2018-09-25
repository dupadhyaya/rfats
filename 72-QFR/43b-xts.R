#xts
#all features of TS of zoo objects
#matrix with time based
#construct from as.xts or xts

library(xts)

library(zoo)
#Date,Volume,Adj Close,Return
#12/14/2016,4144600,198.690002,0.272525

data2 = read.zoo('./32-QFR/DataChap4.csv', header=T, sep=',', format="%m/%d/%Y", nrows=10)
data2
class(data2)
matrix_xts = as.xts(data2, dateFormat='POSIXct')
head(matrix_xts)
class(matrix_xts)
str(matrix_xts)


#construct xts object from scratch
x = matrix(5:8, ncol=2, nrow=2)
x
dt = as.Date(c("2018-09-02","2018-09-03"))
dt
class(dt)

xts_object = xts(x, order.by = dt)
class(xts_object)
xts_object

#xts is subclass of zoo; gets all features of zoo and ts
