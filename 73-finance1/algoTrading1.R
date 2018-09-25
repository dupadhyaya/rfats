#Algo Trading

#https://www.quantinsti.com/blog/an-example-of-a-trading-strategy-coded-in-r/

library(quantmod)
getSymbols("^NSEI")
chartSeries(NSEI, TA=NULL)

data=NSEI[,4]
sum(!complete.cases(data))
data = data[complete.cases(data),]
head(data)
#The command below computes the MACD for the closing price.
macd = MACD(data, nFast=12, nSlow=26,nSig=9,maType=SMA, percent = FALSE)
head(macd)
# library(lubridate)
# lubridate::tz(macd)
# tz(macd) = "Asia/Calcutta"
# Sys.timezone()

chartSeries(NSEI, TA="addMACD()")

signal = Lag(ifelse(macd$macd < macd$signal, -1, 1))
returns = ROC(data)*signal
portfolio = exp(cumsum(returns))

plot(portfolio)

table.Drawdowns(ret, top=10)

table.DownsideRisk(ret)

charts.PerformanceSummary(ret)

#----
require(quantmod)
require(PerformanceAnalytics)
getSymbols('^NSEI')
chartSeries(NSEI, TA=NULL)
data=NSEI[,4]
macd = MACD(data, nFast=12, nSlow=26,nSig=9,maType=SMA,percent = FALSE)
chartSeries(data, TA='addMACD()')
signal = Lag(ifelse(macd$macd < macd$signal, -1, 1))
returns = ROC(data)*signal
returns = returns['2008-06-02/2015-09-22']
portfolio = exp(cumsum(returns))
plot(portfolio)
table.Drawdowns(returns, top=10)
table.DownsideRisk(returns)
charts.PerformanceSummary(returns)
