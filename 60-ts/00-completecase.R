# Time Series Decomposition
#package seas

#read data from text file or keyboard

data1 = scan()
#copy these number line wise and press enter
#45 56 60 35 55 48 49 30 58 41
#56 45 34 60 54 44 56 57 49 31
#56 45 34 58 59 47 48 35 41 58
#after 3rd line press enter on blank line and scan will end

summary(data1)

#convert data into time series
data1ts = ts(data1)
data1ts

#series has min 2 periods for seasonal decomposition
decompose(data1ts)

#create a bigger series with monthly data
(attendance = ceiling(rnorm(12 * 9, mean=60, sd=10)))

attend_ts = ts(attendance, frequency=12)
attend_ts
decompose(attend_ts)

#view as per decomposition required
attend_dc1 = decompose(attend_ts, type='additive')
head(attend_dc1)
plot(attend_dc1)

#seasonal
attend_dc1[[2]]
attend_dc1$seasonal

#non-parametric method
attend_stl = stl(attend_ts, s.window= "periodic")
plot(attend_stl)


#seas package
library(seasonal)
#https://cran.r-project.org/web/packages/seasonal/vignettes/seas.pdf

attend_ts2 = ts(attendance, c(2010,1), frequency=12)
attend_ts2
attend_seas = seas(attend_ts2)
attend_seas
attributes(attend_seas)
attend_seas$model
summary(attend_seas)
final(attend_seas)
