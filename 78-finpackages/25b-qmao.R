# data from google finance

#Not working 
# https://chrisconlan.com/download-historical-stock-data-google-r-python/

library(devtools)
install_github("gsee/qmao") 
#install.packages("qmao", repos="http://R-Forge.R-project.org") 
#install.packages('pander', 'RJSONIO')
library(qmao)
Sys.time()

getQuote("SPY", src="google")
getQuote("SPY", src="yahoo")

getQuote("SPY", src="bats", what="bbo")

#getQuote.bats has a few options for how you want the data to print:

getQuote("SPY", src="bats", what="ladder")  
#not working from bats also