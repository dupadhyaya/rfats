# zoo TS objects


#create a DF 
(purchasedates = as.Date("2018-05-01") + 0:30)  #31 days
(productsales = matrix(ceiling(runif(31 * 4, 50,200)),ncol=4))
colnames(productsales) = paste("P",1:4,sep="-")
(dfsales = data.frame(purchasedates, productsales))
head(dfsales)
myzoo_ts1 = zoo(x = dfsales[2:5], order.by = dfsales$purchasedates, frequency = 1)
myzoo_ts1

myzoo_ts2 = zoo(x = dfsales[2:5], order.by = dfsales$purchasedates, frequency = 2)
myzoo_ts2

class(myzoo_ts2)


#access elements


#plots
plot(myzoo_ts2)
plot(myzoo_ts2, plot.type = "single", col=1:4)
