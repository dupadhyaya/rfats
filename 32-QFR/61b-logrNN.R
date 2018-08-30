#Logistic Regression NN

library(quantmod)
getSymbols("^DJI", src="yahoo")
dji = DJI[ , "DJI.Close"]
head(dji)

#apply methods
avg10 = rollapply(dji, 10, mean)
head(avg10,15)
avg20 = rollapply(dji, 20, mean)
avg20[15:30,]

std10 = rollapply(dji, 10, sd)
std10[5:15,]
std20 = rollapply(dji, 20, sd)
std20[15:25,]

rsi5 = RSI(dji, 5, "SMA")
rsi5[5:15,]
rsi14 = RSI(dji, 14, "SMA")
rsi14[10:25,]

macd12269 = MACD(dji, 12, 26, 9, "SMA")
macd12269[15:25,]
macd7205 = MACD(dji, 7, 20, 5, "SMA")
macd7205[15:25,]

bbands = BBands(dji,20, "SMA", 2)
bbands[15:25,]

#direction----
direction = NULL
direction[dji > Lag(dji, 20)] <- 1
direction[dji < Lag(dji, 20)] <- 0

dji = cbind(dji, avg10, avg20, std10, std20, rsi5, rsi14, macd12269, macd7205, bbands, direction)
dim(dji)

dm = dim(dji)
colnames(dji)[dm[2]]
colnames(dji)[dm[2]] = "Direction"
colnames(dji)[dm[2]]
