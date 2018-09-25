# Charting


#http://www.quantmod.com/examples/charting/
# Financial Charts in quantmod:
# The workhorse: chartSeries
# Meet the friends: barChart, candleChart, and lineChart
# Chart Arguments: what can you do?
# Voodoo: Technical Analysis with TTR and addTA

#-----
#Introducing chartSeries
#chartSeries is the main function doing all the work in quantmod. Courtesy of as.xts it can handle any object that is time-series like, meaning R objects of class xts, zoo, timeSeries, its, ts, irts, and more!
#  By default any series that is.OHLC is charted as an OHLC series. There is a type argument which allows the user to decide on the style to be rendered: traditional bar-charts, candle-charts, and matchstick-charts -- thin candles ... get it :) -- as well as line charts.

#The default choice ['auto'] lets the software decide, candles where they'd be visible clearly, matchsticks if many points are being charted, and lines if the series isn't of an OHLC nature. If you don't like to always specify the type to override this behavior you are free to use the wrapper functions in the next section, or make use of setDefaults from the wickedly cool and useful Defaults package (available on CRAN). The fact that I wrote it has nothing to do with my endorsement :)

library(quantmod)
getSymbols("GS") #Goldman OHLC from yahoo 
chartSeries(GS) 

#GS matchstick chart 
# notice the automatic matchstick style 
# we'll change this in the next section 
# but for now it is fine. 

#Charting shortcuts - barChart, lineChart, and candleChart.
#While chartSeries is the primary function called when drawing a chart in quantmod - it is by no means the only way to get something done. There are wrapper functions for each of the main types of charts presently available in quantmod.

#Wrapper functions exist to make life a little easier. Bar style charts, both hlc and ohlc varieties are directly available with barChart, candlestick charting comes naturally through the candleChart wrapper function, and lines via the cryptically named - you guessed it - lineChart. There isn't much special about these functions beyond the obvious. In fact they are one liners that simply call chartSeries with suitably changed default args. But they make a nice addition to the stable.


# first some high-low-close style bars, monochromatic theme 
barChart(GS,theme='white.mono',bar.type='hlc') 

#GS hlc barchart chart 
# how about some candles, this time with color 
candleChart(GS,multi.col=TRUE,theme='white') 

#GS candle chart 
# and now a line, with the default color scheme 
lineChart(GS,line.type='h',TA=NULL) 


#Formal Arguments: Colors, subsetting, tick-marks.
#The best place for complete information on what arguments the functions take is in the documentation. But for now we'll take a look at some of the common options you might change.

#Probably the most important from a usability standpoint is the argument subset. This takes an xts/ISO8601 style time-based string and restricts the plot to the date/time range specified. This doesn't restrict the data available to the techinical analysis functions, only restricts the content drawn to the screen. For this reason it is most advantageous to use as much data as you have available, and then provide the chartSeries function with the subset which you would like to view. This subsetting is also avialable via a call to zoomChart.

#An example, or three, should help clarify its usage.


# the whole series 
chartSeries(GS) 

# now - a little but of subsetting 
# (December '07 to the last observation in '08) 
candleChart(GS,subset='2007-12::2008') 

# slightly different syntax - after the fact. 
# also changing the x-axis labeling 
candleChart(GS,theme='white', type='candles') 
reChart(major.ticks='months',subset='first 16 weeks') 


#Technical Analysis and chartSeries
getSymbols("GS") #Goldman OHLC from yahoo 
# The TA argument to chartSeries is one way to specify the 
# indicator calls to be applied to the chart. 
# NULL mean don't draw any. 

chartSeries(GS, TA=NULL) 

# Now with some indicators applied 
chartSeries(GS, theme="white", TA="addVo();addBBands();addCCI()") 

# The same result could be accomplished a 
# bit more interactively: 
# 
chartSeries(GS, theme="white") #draw the chart 
addVo() #add volume 
addBBands() #add Bollinger Bands 
addCCI() #add Commodity Channel Index


#-----
getSymbols("SBIN.BO") # SBIOHLC from yahoo 
# addTA allows you to add basic indicators 
# to your charts - even if they aren't part of quantmod. 
chartSeries(SBIN.BO, TA=NULL) 

#Then add the Open to Close price change 
#using the quantmod OpCl function 
addTA(OpCl(SBIN.BO),col='blue', type='h') 
head(SBIN.BO)

# Using newTA it is possible to create your own 
# generic TA function --- let's call it addOpCl 
# 
addOpCl <- newTA(OpCl,col='green',type='h') 
addOpCl() 
