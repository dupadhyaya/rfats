# Quantmod
#https://finance.yahoo.com/

library(quantmod)

# get data for FTSE
my.df <- getSymbols(Symbols = 'SBIN.NS', auto.assign = FALSE)
head(my.df)
?getSymbols
getSymbols(Symbols = 'ICICIBANK.NS')
head(ICICIBANK.NS)
getSymbols(Symbols = 'HDFC.NS', auto.assign = TRUE)
head(HDFC.NS)
getSymbols(Symbols = 'PNB.NS', auto.assign = FALSE)
#no variable created
head(PNB.NS)


