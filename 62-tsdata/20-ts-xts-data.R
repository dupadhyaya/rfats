# xts

#https://stackoverflow.com/questions/52056158/xts-help-me-on-the-usage-differences-between-period-apply-to-period

library(xts)

data(sample_matrix)
sample_matrix

zoo.data <- zoo(rnorm(31)+10,as.Date(13514:13744,origin="1970-01-01"))
head(zoo.data)
zoo.data
# code example 1
to.quarterly(sample_matrix)

# same as to.quarterly
to.period(sample_matrix, period = "quarters")

# code example 2
to.period(zoo.data, period = "quarters")

# code example 3 using base standard deviation in the chosen period
period.apply(zoo.data, endpoints(zoo.data, on = "quarters"), sd)


# self defined function of summing x + x for the period
period.apply(zoo.data, endpoints(zoo.data, on = "quarters"), function(x) sum(x + x) )

tail(sample_matrix)
# code example 5
period.apply(sample_matrix, endpoints(sample_matrix, on = "quarters"), colMeans)
#quarterly means: sum for quarter and then means

