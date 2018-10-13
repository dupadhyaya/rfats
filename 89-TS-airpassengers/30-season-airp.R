#https://cran.r-project.org/web/packages/seasonal/vignettes/seas.pdf

#install.packages("seasonal")
library(seasonal)

#install.packages("seasonalview")
library(seasonalview)

str(AirPassengers)
head(AirPassengers)
AirPassengers
# first argument of seas has to be a time series of class "ts". The function returns an object of class "seas" that contains all necessary information on the adjustment

m <- seas(AirPassengers)

#There are several functions and methods for "seas" objects: The final function returns the adjusted series, the plot method shows a plot with the unadjusted and the adjusted series. The summary method allows you to display an overview of the model:

final(m)
plot(m)
summary(m)

#By default, seas calls the SEATS adjustment procedure. If you prefer the X11 adjustment procedure
seas(AirPassengers, x11 = "")

#A default call to seas also invokes the following automatic procedures of X -13ARIMA-SEATS:
#Transformation selection (log / no log)
#Detection of trading day and Easter effects
#Outlier detection
#ARIMA model search

#Alternatively, all inputs may be entered manually, as in the following example:
seas(x = AirPassengers,  regression.variables = c("td1coef", "easter[1]", "ao1951.May"), arima.model = "(0 1 1)(0 1 1)", regression.aictest = NULL, outlier = NULL, transform.function = "log")

#The static command returns the manual call of a model. The call above can be easily generated from the automatic model:
static(m)
static(m, coef = TRUE) # also fixes the coefficients

#If you have seasonalview installed, the view command offers an easy way to analyze and modify a seasonal adjustment procedure (see the section below for details):
view(m)


#------------------------------
m <- seas(AirPassengers, regression.variables = c("td", "ao1955.jan"))
m

seas(AirPassengers, x11 = "",  arima.model = "(0 1 1)")
seas(list = list(x = AirPassengers, x11 = ""))
update(m, regression.variables = "td", x11 = "")
update(m, x = sqrt(AirPassengers))
predict(m, newdata = sqrt(AirPassengers))


#OUTPUT -------------------------------------------
m <- seas(AirPassengers)
series(m, "forecast.forecasts")

series(m, c("forecast.forecasts", "s12"))
m <- seas(AirPassengers, forecast.save = "forecasts")
m <- seas(AirPassengers)
series(m, "history.saestimates")
series(m, "slidingspans.sfspans")

udg(m, "x13mdl")

out(m)


#Graphs
m <- seas(AirPassengers, regression.aictest = c("td", "easter"))
plot(m)

monthplot(m)
monthplot(m, choice = "irregular")

pacf(resid(m))
spectrum(diff(resid(m)))
plot(density(resid(m)))
qqnorm(resid(m))


#GUI
view(m)


#Holiday
# variables included in seasonal
# iip: Indian industrial production
# cny, diwali, easter: dates of Chinese New Year, Indian Diwali and Easter
seas(iip,  x11 = "", xreg = genhol(diwali, start = 0, end = 0, center = "calendar"), regression.usertype = "holiday")


#later date TS
ap.short <- window(AirPassengers, end = c(1959, 12))
m <- seas(ap.short)
m

m.static <- static(m, evaluate = TRUE)

update(m, x = AirPassengers)
update(m.static, x = AirPassengers)


# collect data
dta <- list(fdeaths = fdeaths, mdeaths = mdeaths)
# loop over dta
l1 <- lapply(dta, function(e) try(seas(e, x11 = "")))
# list failing models
is.err <- sapply(l1, class) == "try-error"
l1[is.err]
# return final series of successful evaluations
do.call(cbind, lapply(l1[!is.err], final))

#If you have several cores and want to speed things up, the process is well suited for parallelization:
# a list with 100 time series
l2 <- rep(list(AirPassengers), 100)

#
library(parallel) # this is part of a standard R installation

# set up cluster
cl <- makeCluster(detectCores())
cl

# load 'seasonal' for each node
clusterEvalQ(cl, library(seasonal))

# export data to each node
clusterExport(cl, varlist = "l2")
# run in parallel (2.2s on a 4-core / 8-thread Macbook, vs 9.6s with standard lapply)
parLapply(cl, l2, function(e) try(seas(e, x11 = "")))
# finally, stop the cluster
stopCluster(cl)

# importing the orginal X-13 example file
import.spc(system.file("tests", "Testairline.spc", package="seasonal"))
