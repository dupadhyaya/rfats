#Import Quotes from Yahoo Finance

library(quantmod)
Symbols= 'HCLTECH.NS'
getSymbols.yahoo(Symbols)
HCLTECH.NS
getSymbols.yahoo(Symbols, env, return.class = 'xts',
                 from = "2007-01-01",
                 to = Sys.Date())
getSymbols('ICICIBANK.NS',src='yahoo')
head(ICICIBANK.NS)
sum(is.na(ICICIBANK.NS))  # check for missing values

getSymbols(c('ICICIBANK.NS','HCLTECH.NS'),src='yahoo')
head(ICICIBANK.NS)
head(HCLTECH.NS)

setSymbolLookup(MSFT='yahoo')
MSFT
