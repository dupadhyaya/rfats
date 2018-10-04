# Zoo Time Series

library(zoo)


# Create the TS object data for 1 single column using 5 random numbers
(data = rnorm(5))

# Create dates as a Date class object starting from 2016-01-01
(dates = seq(as.Date("2016-01-01"), length = 5, by = "days"))

# Use zoo() 
(zoo_ts = zoo(x = data, order.by = dates))

#Matrix format Data 
(mu = c(60,65))
#relationship between variables :cor=0.5, var(1)=9,Var(2)=16, Cov=6 (same from both directions). 
(sigma = matrix(c(9,6,6,16),nrow= 2, ncol=2))
library(MASS)
m1= mvrnorm(1000, mu, sigma)
colMeans(m1)
apply(m1, 2, var)
cov(m1)
plot(density(m1[,1]))
lines(density(m1[,2]), col=2)
abline(v=c(60,65), col=1:2)
head(m1)

(dates2 = seq(as.Date("2016-01-01"), length = 1000, by = "days"))

# Use zoo() 
(zoo_ts2 = zoo(x = m1, order.by = dates2))

