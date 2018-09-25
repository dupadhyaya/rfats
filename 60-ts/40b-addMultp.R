#TS Model
# additive or multiplicative
#https://itsalocke.com/blog/is-my-time-series-additive-or-multiplicative/
#https://www.r-bloggers.com/is-my-time-series-additive-or-multiplicative/
#https://gist.github.com/stephlocke/682f618e36b07945aa48871e0563b3fa
# nzbop data set from ggseas to, first of all, examine a single time series and then process all the time series in the dataset to determine if they’re multiplicative or additive.
if(!require("ggseas")) install.packages("ggseas")
if(!require("forecast")) install.packages("forecast")
if(!require("data.table")) install.packages("data.table")
if(!require("knitr")) install.packages("knitr")

data(nzbop)
nzbop
str(nzbop)
head(nzbop)
summary(nzbop)


library(ggseas)
library(forecast)
library(data.table)

# Get data
nzdata<-data.table(nzbop)
nzdata<-nzdata[!((Account=="Capital account"&   Category=="Balance")| (Account=="Financial account"& Category=="Foreign inv. in NZ; Financial derivative liabilities")|       (Category=="Secondary income balance")),]

sample_ts<-nzdata[Account == "Current account" & Category=="Services; Exports total",       .(TimePeriod, Value)]
knitr::kable(head(sample_ts))

# Add trend
sample_ts[,trend := zoo::rollmean(Value, 8, fill=NA, align = "right")]
knitr::kable(tail(sample_ts))

# De-trend data
sample_ts[,`:=`( detrended_a = Value - trend,  detrended_m = Value / trend )]
knitr::kable(tail(sample_ts))

# Make seasonals
sample_ts[,`:=`(seasonal_a = mean(detrended_a, na.rm = TRUE),
                seasonal_m = mean(detrended_m, na.rm = TRUE)), 
          by=.(quarter(TimePeriod)) ]
knitr::kable(tail(sample_ts))

# Make residuals
sample_ts[,`:=`( residual_a = detrended_a - seasonal_a, 
                 residual_m = detrended_m / seasonal_m )]
knitr::kable(tail(sample_ts))

# Visuals
ggsdc(sample_ts, aes(x = TimePeriod, y = Value), method = "decompose", 
      frequency = 4, s.window = 8, type = "additive")+ geom_line()+
  ggtitle("Additive")+ theme_minimal()

ggsdc(sample_ts, aes(x=TimePeriod, y=Value), method = "decompose", 
      frequency=4, s.window=8, type = "multiplicative")+ geom_line()+
  ggtitle("Multiplicative")+ theme_minimal()

# Auto-correlated factor
ssacf<- function(x) sum(acf(x, na.action = na.omit)$acf^2)
compare_ssacf<-function(add,mult) ifelse(ssacf(add)< ssacf(mult), 
                                         "Additive", "Multiplicative") 
knitr::kable(sample_ts[,.(compare_ssacf(residual_a, residual_m ))])

# Combined function
ssacf<- function(x) sum(acf(x, na.action = na.omit, plot = FALSE)$acf^2)
compare_ssacf<-function(add,mult) ifelse(ssacf(add)< ssacf(mult), 
                                         "Additive", "Multiplicative") 
additive_or_multiplicative <- function(dt){
  m<-copy(dt)
  m[,trend := zoo::rollmean(Value, 8, fill="extend", align = "right")]
  m[,`:=`( detrended_a = Value - trend,  detrended_m = Value / trend )]
  m[Value==0,detrended_m:= 0]
  m[,`:=`(seasonal_a = mean(detrended_a, na.rm = TRUE),
          seasonal_m = mean(detrended_m, na.rm = TRUE)), 
    by=.(quarter(TimePeriod)) ]
  m[is.infinite(seasonal_m),seasonal_m:= 1]
  m[,`:=`( residual_a = detrended_a - seasonal_a, 
           residual_m = detrended_m / seasonal_m)]
  compare_ssacf(m$residual_a, m$residual_m )
}

# Applying it to all time series in table
results<-nzdata[,.(Type=additive_or_multiplicative(.SD)), 
                .(Account, Category)]

knitr::kable(results)
