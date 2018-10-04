#Filters  - xts


#create xts object when more than 1 series
(sbi = ceiling(runif(30, 200, 300)))
(icici = ceiling(rnorm(30, 320, 25)))
shares = data.frame(sbi,icici)
head(shares)
#https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/seq.Date
(dates = seq(as.Date("2019/1/1"), by = "3 day", length.out=30))
#alternate dates
xts_ts = xts(x=shares, order.by = dates)
head(xts_ts)

filter(xts_ts, filter=rep(1/5, 5))
