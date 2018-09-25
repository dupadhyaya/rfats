#quantmod
#OHLC http://www.quantmod.com/examples/data/

# OHLC data - the basics
# OHLC - beyond the obvious
# Subsetting by date - characters and '::' notation
# The last 3 days of the first 2 weeks - interested yet?
# Minutes to hours to days to months - fast aggregation.
# Apply by Period - weekly, monthly or arbitrarily


#Op,Hi,Lo,Cl,Vo,Ad - do pretty much what they say - extract the columns Open, High, Low, Close, Volume, and Adjusted (Yahoo)
#is.OHLC, has.OHLC, has.Op,has.Cl,has.Hi,has.Lo,has.Ad, and has.Vo - fairly obvious seriesHi and seriesLo

library(quantmod)
getSymbols("GS") #Goldman OHLC from yahoo 
#[1] "GS" 
is.OHLC(GS) # does the data contain at least OHL and C? 
has.Vo(GS) # how about volume? 
Op(GS) # just the Open column please. 
seriesHi(GS) # where and what was the high point
range(GS)
range(GS$GS.Open)
head(GS)
tail(GS)



#Typically one would like to see what is happening within an observation, or across a period of observations. That may mean some sort of change in price or volume, be it over one period, or over many periods. In the same simplistic fashion as above, one can get price changes for all combinations of columns, across all possible periods

#Simply combine the columns extraction tools from above to arrive at the naming convention to get price changes. Want Open to Close percent change? It is as simple as OpCl.

OpCl(GS) #daily percent change open to close 
OpOp(GS) #one period open to open change 
HiCl(GS) #the percent change from high to close
head(GS)
head(HiCl(GS))
(200.72-203.32)/200.72


#------
#Lag: What was the previous value in the series
#Next: What is the next value in the series
#Delt: Compute the change (delta) from two prices

Lag(Cl(GS)) #One period lag of the close 
head(GS)
head(Lag(Cl(GS)))

Lag(Cl(GS),c(1,3,5)) #One, three, and five period lags 
head(Lag(Cl(GS),c(1,3,5)))
head(GS)

Next(OpCl(GS)) #The next periods open to close - today! 
head(Next(OpCl(GS)))
head(GS)
200.72 - 200.22

# Open to close one-day, two-day and three-day lags 
Delt(Op(GS),Cl(GS),k=1:3)



#Subsetting by Time and Date? -- xts Makes It Easy
#One of the central motivations for creating the xts package was to offer tools that made it easy to work with time-based series. Extending the zoo class, a new method specific to xts series allows for sub-setting via the traditional R bracket mechanism, but with a twist.
library(zoo)

GS['2007'] #returns all Goldman's 2007 OHLC 
GS['2018'] #now just 2018 
GS['2018-08'] #now just January of 2018 
GS['2018-06::2008-01-09'] #
GS['::'] # everything in GS 
GS['2010::'] # everything in GS, from 2010 onward 
non.contiguous <- c('2016-01','2017-02','2018-12') 
GS[non.contiguous]

#general format for the above is CCYY-MM-DD HH:MM:SS, with ranges specified via the '::' operator. The only requirement is that you specify the level of detail from left to right - that is to get January, you need to specify the year first. The coolest part to this construct is that it is now posssible to only specify the level of detail you require in the returned object; no longer is it necessary to worry about the underlying level of resolution to your data. Monthly data, or minute data, can both be resolved with the same construction.


#The Last 3 Days of The First 2 Weeks
#Another common problem when trying to subset time series data often involves looking at a particular time period. Often the last n-periods may be desired when charting the price of a security, or when constructing a model for trading or analysis. [Note: these functions are now in the standalone package xts - which quantmod requires]

#To facilitate this 'time-based' subsetting, one can use the functions first and last. Essentially extending the concept of head and tail, one can now use character strings to describe the part of the data to be returned. As is probably expected by now - an example may help to clarify.

first(GS)  
last(GS) #returns the last obs. 
last(GS,8) #returns the last 8 obs. 

# let's try something a bit cooler. 
last(GS, '3 weeks') 
last(GS, '-3 weeks') # all except the last 3 weeks 
last(GS, '3 months') 

#from first 2 weeks, last 3 days
first(GS, '2 weeks')
last(first(GS, '2 weeks'), '3 days')


#Aggregating to a different time scale
#Often, and especially with higher frequency data, it is necessary to aggregate data into lower frequency terms. For example, take daily data - OHLC or a standard time series - and convert it to weekly or monthly OHLC data.

#With xts it is as simple as to.weekly or to.monthly. In fact, it is currently possible to take everything from minute data all the way up to quarterly data and convert it into something lower frequency. Minute data can become 5 or 10 minute data (to.minutes5 and to.minutes10, respectively), which can in turn be turned into hourly or daily data. Daily data can become weekly, monthly, or even yearly. All carried out in compiled code, and all blazingly fast, yes blazingly fast - convert 2 months of 1-minute bars into 3-minute bars in less than 0.1 seconds and anything lower in half that time. A full year of minute bars in less than a second on a moderately fast computer.

#Is your data weekly, daily, or hourly? A call to periodicity will provide the answer; a call to nweeks will tell you the number of weeks as well.

periodicity(GS) 
unclass(periodicity(GS)) 
to.weekly(GS)
#The result will contain the open and close for the given period, as well as the maximum and minimum over the new period, reflected in the new high and low, respectively. If volume for a period was available, the new volume will also be calculated.
?to.weekly

to.monthly(GS) 
periodicity(to.monthly(GS)) 
to.yearly(GS)
to.yearly(GS['2016::2018'])

ndays(GS); nweeks(GS); nyears(GS) 

# Let's try some non-OHLC to start 
getFX("USD/EUR") 
periodicity(USDEUR) 
to.weekly(USDEUR) 
periodicity(to.weekly(USDEUR))


#-----
#Apply by Period
#It may be useful to identify endpoints in your data by date with the function endpoints. You can use those endpoints (or ones generated automatically) with the functions in the period.apply family. Quickly calculate periodic minimums, maximums, sums, and products - as well as general applys (with the periodic slant) with a few simple functions.

endpoints(GS,on="months") 

# find the maximum closing price each week 
apply.weekly(GS,FUN=function(x) { max(Cl(x)) } ) 

# the same thing - only more general 
period.apply(GS,endpoints(GS,on='weeks'),FUN=function(x){max(Cl(x)) } ) 

# same thing - only 50x faster! 
as.numeric(period.max(Cl(GS),endpoints(GS,on='weeks')))

#Of course, additional wrappers exist to quickly apply arbitrary functions over daily, monthly, quarterly and annual time periods as well. There are also Fortran-based routines for period.min, period.sum, and period.prod, in addition to the period.max function.

#Period Returns
#The last set of functions simply provide a fast and reliable way to calculate returns over calendar periods - derived from the function periodReturn. Named for what they return. A note on starting/ending date convention, all periods could be named in a variety of ways - the first of the period, the first trading time of the period, the last trading time of the period, or even the last day of the period. xts has adopted the last observation of a given period as the date to record for the larger period. There may be a point in the future where this is settable as well. This is now user settable through the indexAt argument to the underlying to.period versions to.monthly and to.quarterly. The full details can be found in the related help pages, but a quick explanation is indexAt lets one set the resulting index to the first of each period (firstof), the last of each period (lastof), the starting observation of the period (startof), the ending observation of the period (endof), the month of the period (yearmon) or the quarter of the period (yearqtr). For most classes of time-series data this defaults to yearmon for monthly observations and yearqtr for quarterly requests.

# Quick returns - quantmod style 
getSymbols("SBUX") 

dailyReturn(SBUX) # returns by day 
weeklyReturn(SBUX) # returns by week 
monthlyReturn(SBUX) # returns by month, indexed by yearmon 

# daily,weekly,monthly,quarterly, and yearly 
allReturns(SBUX) # note the plural
