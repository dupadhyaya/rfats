#Get Symbols
#https://amzn.to/2I5FFnE

library(BatchGetSymbols)

# set dates
first.date <- Sys.Date() - 60
last.date <- Sys.Date()

# set tickers
tickers <- c('SBIN.NS','HDFC.NS','ICICIBANK.NS','RELIANCE.NS')

l.out <- BatchGetSymbols(tickers = tickers,  first.date = first.date, last.date = last.date,  cache.folder = file.path(tempdir(), 'BGS_Cache') ) # cache in tempdir()

print(l.out$df.control)

library(ggplot2)

#daily closing price
p <- ggplot(l.out$df.tickers, aes(x = ref.date, y = price.close))
p <- p + geom_line()
p <- p + facet_wrap(~ticker, scales = 'free_y') 
print(p)


#NSE - https://in.finance.yahoo.com/quote/%5Ensei/
#^NSEI NIFTY 50 (^NSEI)

#get all tickers



library(BatchGetSymbols)
first.date <- Sys.Date()-365
last.date <- Sys.Date()
df.SP500 <- GetSP500Stocks()
tickers <- df.SP500$tickers
#time consuming process
#l.out <- BatchGetSymbols(tickers = tickers,first.date = first.date,  last.date = last.date)
print(l.out$df.control)
print(l.out$df.tickers)