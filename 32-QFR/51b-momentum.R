#Quant Finance -R
#Momentum or Directional Trading

library(quantmod)
#Dow Jones INdex from Yahoo Repository
getSymbols("^DJI", src="yahoo")
#data consists of many columns Open, High, Low, Close...

head(DJI)
names((DJI))
class(DJI)
#time series object
dji = DJI[, "DJI.Close"]
range(dji)
summary(dji)  #date and close value

dji = dji[(index >= "2010-01-01" & index <= "2015-12-31"), ]

#returns
ret_dji = Delt(dji, k=1)
head(ret_dji,n=3)
#manual calc
dji[1]; dji[2]
(as.numeric(dji[2]) - as.numeric(dji[1]))/ as.numeric(dji[1])
(as.numeric(dji[3]) - as.numeric(dji[2]))/ as.numeric(dji[2])
# and so on ..

ret_dji_3 = Delt(dji, k=1:3)
head(ret_dji_3)
(as.numeric(dji[2]) - as.numeric(dji[1]))/ as.numeric(dji[1])
(as.numeric(dji[3]) - as.numeric(dji[1]))/ as.numeric(dji[1])
(as.numeric(dji[4]) - as.numeric(dji[1]))/ as.numeric(dji[1])

#plots
plot(dji)
plot(ret_dji)
plot(ret_dji_3)


#Generate Singals at appropriate times , potential to generate +ve ROI
#train and test Set
in_sd = "2010-01-01"
in_ed = "2014-12-31"
out_sd = "2015-01-01"
out_ed = "2015-12-31"

head(dji); head(ret_dji_3)
in_dji = dji [ (index(dji) >= in_sd & index(dji) <= in_ed), ]
head(in_dji)
in_ret_dji = ret_dji_3 [ (index(ret_dji_3) >= in_sd & index(ret_dji_3) <= in_ed), ]
head(in_ret_dji)

out_dji = dji [ (index(dji) >= out_sd & index(dji) <= out_ed), ]
head(out_dji)
out_ret_dji = ret_dji_3 [ (index(ret_dji_3) >= out_sd & index(ret_dji_3) <= out_ed), ]
head(out_ret_dji)

#MACD
macd = MACD(in_dji, nFast=12, nSlow=26, nSig=9, maType="SMA", percent=F)
head(macd,n=45)

bb=BBands(in_dji, n=20, maType="SMA", sd=2)
head(bb,n=45)

signal = NULL
signal = ifelse(in_dji > bb[,'up'], macd[,'macd'])
in_dji > bb[,'up']
macd[,'macd']
