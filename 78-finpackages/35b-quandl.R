#Package Quandl

#Another major source of financial data is the Quandl platform. It is an established and comprehensive system that provides access to a series of free and paid data. It provides information for several types of financial markets, such as equity, options, futures, currencies, commodities, and more. Several central banks and research institutions also provide economic and financial information in this platform. I strongly recommend browsing the available datasets from the Quandl website.

library(Quandl)

#The first step in using Quandl is to register a new user at the website. Soon after, go to account settings and click API KEY. This page should show a code, such as Asv8Ac7zuZzJSCGxynfG. Copy this text to the clipboard (Control + c) and, in R, define a character object containing the copied content as follows

#4D8hkYAV4WEkcTmD9LMW
# set api key to quandl
my.api.key <- '4D8hkYAV4WEkcTmD9LMW'

#This API key is unique to each user, and the one presented here will not work in your computer. You need to get your own to run the examples. After finding and setting your own API key, go to Quandl’s website and look for the symbol of the time series of interest. 

# search string in quandl
df.search <- Quandl.search('Gold in Euro', silent = TRUE)

# print columns from 
print(colnames(df.search))

# register api key
Quandl.api_key(my.api.key)

# set symbol and dates
my.symbol <- 'WGC/GOLD_DAILY_EUR'
first.date <- as.Date('2016-01-01')
last.date <- Sys.Date()

# get data!
my.df <- Quandl(code = my.symbol,  type='raw', start_date = first.date, end_date = last.date)

print(tail(my.df))
