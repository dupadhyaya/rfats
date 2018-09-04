#Package finreportr
#https://msperlin.github.io/pafdR/importingInternet.html

library(finreportr)
# print available functions in finreportr
ls('package:finreportr')

my.ticker <- 'FB'
#not getting for indian coy
info <- CompanyInfo(my.ticker)
print(info)

# set final year
my.year <- 2016

# get income for FB
my.income <- GetIncome(my.ticker, my.year)

# print result
print(head(my.income))

# get unique fields
unique.fields <- unique(my.income$Metric)

# cut size of string
unique.fields <- substr(unique.fields,1, 60)

# print result
print(unique.fields)
# set col and date
my.col <- 'Earnings Per Share, Basic'

# print earnings per share
print(my.income[my.income$Metric == my.col, ])
