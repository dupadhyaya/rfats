#Wavelets Analysis - Multi Resolution Analysis (MRA)
#Chap3 - 89

#install.packages('wavelets')
library(wavelets)

library(quantmod)
#Dow Jones Industrial Average(DJIA)
getSymbols('^DJI',src="yahoo")
dji = DJI[,"DJI.Close"]
dji = dji[index(dji) >= "2010-01-01" & index(dji) <= "2015-12-31"]
head(dji)
ret_dji = Delt(dji, k=1)
head(ret_dji)

#S&P500 Index
getSymbols('^GSPC',src="yahoo")
GSPC
snp = GSPC[,"GSPC.Close"]
snp = snp[index(snp) >= "2010-01-01" & index(snp) <= "2015-12-31"]
head(snp)
ret_snp = Delt(snp, k=1)
head(ret_snp)
var(ret_snp, na.rm=T)

#Plot - clear graph
par(mfrow=c(1,1))
plot(dji, type="l")
plot(ret_dji, type="l")

#apply Discret WT
#data to be in TS
class(dji)
dji = as.ts(dji)
class(dji)

#model3 : MRA
model3 = mra(dji, filter="la8", n.levels = 3)

#model4 : MODWT - for market data
model4 = modwt(dji, filter="la8", n.levels = 5)

plot(model4)
#few jumps in TS are seen 
