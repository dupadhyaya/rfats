# Frequency in TS

#The "frequency" is the number of observations per "cycle" (normally a year, but sometimes a week, a day, an hour, etc). This is the opposite of the definition of frequency in physics, or in Fourier analysis, where "period" is the length of the cycle, and "frequency" is the inverse of period. When using the ts() function in R, the following choices should be used.

# Data      frequency
# Annual     1
# Quarterly  4
# Monthly   12
# Weekly    52
# Actually, there are not 52 weeks in a year, but 365.25/7 = 52.18 on average. But most functions which use ts objects require integer frequency.

#Once the frequency of observations is smaller than a week, then there is usually more than one way of handling the frequency. For example, data observed every minute might have an hourly seasonality (frequency=60), a daily seasonality (frequency=24x60=1440), a weekly seasonality (frequency=24x60x7=10080) and an annual seasonality (frequency=24x60x365.25=525960). If you want to use a ts object, then you need to decide which of these is the most important.

#An alternative is to use a msts object (defined in the forecast package) which handles multiple seasonality time series. Then you can specify all the frequencies that might be relevant. It is also flexible enough to handle non-integer frequencies.

You won't necessarily want to include all of these frequencies --- just the ones that are likely to be present in the data. As you have only 180 days of data, you can probably ignore the annual seasonality. If the data are measurements of a natural phenomenon (e.g., temperature), you might also be able to ignore the weekly seasonality.