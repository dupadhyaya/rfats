#Mergin ts , zoo objects

#create two TS Objects

(coy1 = ceiling(runif(48, 20,100)))
length(coy1)
(coy2 = ceiling(runif(48, 20,80)))
(ts_coy1 = ts(coy1, start=c(2010,1), frequency=12))
(ts_coy2 = ts(coy2, start=c(2010,1), frequency=12))

#combine as ts
(ts_coy1coy2 = cbind(ts_coy1, ts_coy2)) # this will create a DF with 2 columns mon/yr as index
class(ts_coy1coy2)  #mts

#combine as zoo
(zoo_coy1coy2= cbind(as.zoo(ts_coy1), as.zoo(ts_coy1)))
class(zoo_coy1coy2)

#use data vector with index 
(zoo_c1c2 = as.zoo(coy1coy2, order.by=index(ts_coy1)))
class(zoo_c1c2)


#combine as xts
(xts_coy1coy2= cbind(as.xts(ts_coy1), as.xts(ts_coy1)))
class(xts_coy1coy2)






