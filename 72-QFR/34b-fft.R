#Fast Fourier Transform FFT

library(quantmod)
#Dow Jones Industrial Average(DJIA)
getSymbols('^DJI',src="yahoo")
dji = DJI[,"DJI.Close"]
dji = dji[index(dji) >= "2010-01-01" & index(dji) <= "2015-12-31"]
head(dji)
ret_dji = Delt(dji, k=1)
head(ret_dji)


#install.packages('fftw')
library(fftw)

model1 = stats::fft(dji)

model1
#transformed series consisting of complex numbers.
#extract parts

rp = Re(model1)
ip = Im(model1)

#absolute value of the model
absmodel1 = abs(model1)
absmodel1

plot(absmodel1)

#normalise
norm_absmodel1 = absmodel1[1:(length(dji)/2)]
angle = atan2(ip, rp)
angle

#spectrum density
spec_density = spectrum(dji, method = c('pgram','ar'))
