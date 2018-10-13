#Candlestick Chart

library(candlesticks)

## Not run: 
getSymbols("SBIN.BO", src="yahoo")
#getSymbols('APPL',adjust=TRUE)

tsdata1 = na.omit(SBIN.BO)
head(tsdata1)
has.OHLC(tsdata1)

CSPMarubozu(tsdata1)



# include not-so-long-marubozus
CSPMarubozu(YHOO, ATRFactor=.8)

# filter for white closing marubozus (Cl(TS)=Hi(TS))
CSPMarubozu(tsdata1, maxuppershadowCL=0)[,"WhiteMarubozu"]


#practise
x=tsdata[1:30]
chart_Series(x)
chart_pars(x, type="bars")
dygraphs::dyAnnotation()
?chart_Series
chartSeries(x, type = c("auto", "candlesticks", "matchsticks", "bars","line"),subset = NULL,     show.grid = TRUE, name = NULL, time.scale = NULL,  log.scale = FALSE,  TA = 'addVo()', TAsep=';',line.type = "l",  bar.type = "ohlc", theme = chartTheme("black"), layout = NA,  major.ticks='auto', minor.ticks=TRUE, yrange=NULL, plot=TRUE,up.col,dn.col,color.vol = TRUE, multi.col = FALSE)


library(xts)
library(dplyr)
data(sample_matrix)
dygraph(sample_matrix) %>%  dyCandlestick(compress = TRUE)
