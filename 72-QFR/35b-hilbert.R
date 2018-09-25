#Hilbert Transformation

library(quantmod)
#Dow Jones Industrial Average(DJIA)
getSymbols('^DJI',src="yahoo")
dji = DJI[,"DJI.Close"]
dji = dji[index(dji) >= "2010-01-01" & index(dji) <= "2015-12-31"]
head(dji)
ret_dji = Delt(dji, k=1)
head(ret_dji)


#install.packages('seewave')
library(seewave)

model1 = hilbert(dji,1)

model1
summary(model1)

rp = Re(model1)
ip = Im(model1)

ifreq(dji, 1, ylim=c(0,0.0001))

ifreq(dji, 1, phase="TRUE", ylim=c(-0.5, 1))

output = ifreq(dji, 1, plot=FALSE)
freq = output$f
freq
phase = output$p

#if values of 2 phases are calc then calc
#phase_difference = phase1 - phase2

