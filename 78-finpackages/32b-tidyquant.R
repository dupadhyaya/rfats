#Package tidyquant

#Package tidyquant provides functions related to financial data acquisition and processing. It is an ambitious project that offers many solutions in the field of finance
#The package includes functions for obtaining financial data from the web, manipulation of financial data, and the calculation of performance measures of portfolios. It also integrates nicely with the pipeline operator, 


library(tidyquant)

# set stock and dates
#my.ticker <- 'AAPL'
my.ticker <- 'SBIN.NS'

first.date <- '2017-01-01'
last.date <-  Sys.Date()

# get data with tq_get
my.df <- tq_get(my.ticker, get = "stock.prices", from = first.date, to = last.date)

print(tail(my.df))

#the price data is the same as using quantmod and BatchGetSymbols. In fact, the origin of it is the same, Yahoo Finance. One interesting aspect of tidyquant is the same function, tq_get, can be used to download other financial information from different sources, such as Google Finance, Morning Star, FRED, and Oanda. For example, we can download key financial ratios from Morning Star by setting get='key.ratios' in tq_get

# get key financial rations of AAPL
#df.key.ratios <- tq_get("SBIN.NS",get = "key.ratios")
df.key.ratios <- tq_get("AAPL",get = "key.ratios")

# print it
print(df.key.ratios)    

# get profitability table
df.profitability <- df.key.ratios$data[[2]]

# print it
print(tail(df.profitability))


# get stocks in AMEX
print(head(tq_exchange('AMEX')))

#print(head(tq_exchange('NSEI')))  #not valid

# print available indices
print(tq_index_options())

# get components of "DOWJONES"
print(tq_index("DOWJONES"))
