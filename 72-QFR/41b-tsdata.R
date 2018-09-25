# Convert data into TS

#TS  is the sequence 
stockprice = round(runif(12, min=50, max=100),0)

stockprice

sp1 = ts(stockprice, start=c(2017,1), frequency=12)
sp1
plot(sp1)
