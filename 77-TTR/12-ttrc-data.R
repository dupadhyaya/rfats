#sample data in TTR

library(TTR)
data(ttrc)
head(ttrc)

class(ttrc)
str(ttrc)

# TTR automatically handles:
data(ttrc)
#zoo / xts
x <- xts(ttrc[,-1],ttrc[,1])
head(x)
class(x)

class(RSI(Cl(x),2))

#timeSeries

#ts

#its

#irts

#fts

#data.frame

#matrix
> 
[1] "xts" "zoo"
> class(RSI(as.timeSeries(Cl(x)),2))
[1] "timeSeries"
attr(,"package")
[1] "timeSeries"
> class(RSI(as.zoo(Cl(x)),2))
[1] "zoo"