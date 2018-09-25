#Plot TS

(coy1 = ceiling(runif(18, 20,100)))
length(coy1)
(coy2 = ceiling(runif(18, 20,80)))
(ts_coy1 = ts(coy1, start=c(2000,1), frequency=1))
(ts_coy2 = ts(coy2, start=c(2000,1), frequency=1))

#combine as ts
(ts_coy1coy2 = cbind(ts_coy1, ts_coy2)) # this will create a DF with 2 columns mon/yr as index
class(ts_coy1coy2)  #mts

plot(ts_coy1coy2)

plot(ts_coy1coy2, plot.type = "single", col=c("blue",'red'))

legend(x="topleft", legend=c("Coy1","Coy2"), col=c("blue","red"), lty=1:2)

