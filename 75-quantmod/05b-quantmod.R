
library(quantmod)

getSymbols("HDFCBANK.BO", src="yahoo")
HDFCBANK.BO
tail(HDFCBANK.BO)
getSymbols("IDFC.NS", src="yahoo")

#.BO for BSE and .NS for NSE
getSymbols("SBIN.BO", src="yahoo")
head(SBIN.BO[complete.cases(SBIN.BO)])
tail(SBIN.BO[complete.cases(SBIN.BO)])

getSymbols("SBIN.NS", src="yahoo")


#library(quantmod)
getSymbols("^BSESN",src="yahoo" , from ="2016-10-23", to = Sys.Date())
View(BSESN)
chart_Series(BSESN)

#Analyze One Year Data of Bombay Stock Exchange-
getSymbols("^BSESN",src="yahoo" , from ="2015-10-23", to = Sys.Date())
chart_Series(BSESN,type = "candlesticks")

#Complete Data of Bombay Stock Exchange–
#It will provide you all data after 2007.
getSymbols("^BSESN",src="yahoo")
chart_Series(BSESN)



