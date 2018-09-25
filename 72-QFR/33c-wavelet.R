#Wavelets Analysis
#Chap3 - 85

#install.packages('wavelets')
library(wavelets)

library(quantmod)
#Dow Jones Industrial Average(DJIA)
getSymbols('^DJI',src="yahoo")
dji = DJI[,"DJI.Close"]
head(dji)
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

head(snp)
snp

plot(dji, type="l")
#Plot - clear graph
par(mfrow=c(1,1))
plot(dji, type="l")
plot(ret_dji, type="l")

#apply Discret WT
#data to be in TS
class(dji)
dji = as.ts(dji)
class(dji)

#model
model = dwt(dji, filter="la8", n.levels = 3)
model
summary(model)
attributes(model)
names(model)
methods(model)
#extract info
model@W
model@V
model@W$W1
model@V$V1

plot(model)

model2 = dwt(dji, filter="haar", n.levels=3)
plot(model2)

#inverse DWT
imodel2 = idwt(model2, fast=T)
class(imodel2)
head(imodel2)

