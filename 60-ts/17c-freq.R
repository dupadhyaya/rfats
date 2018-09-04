#Frequency in TS
#https://dzone.com/articles/seasonal-periods

data = round(rnorm(100, mean=70, sd=10))
data

freq1 = ts(data, frequency=1)
freq1

freq2 = ts(data, frequency=2)
freq2
