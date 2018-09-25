#Statistics

#Section - Statistics (Mean, Median, Mode, Kurtosis, Skewness)    
head(Sampledata)

# Finding Mean
mean(Sampledata$Volume)

# Finding Median
median(Sampledata$Volume)

# Finding Mode
findmode <- function(x) {
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x, uniqx)))]
}
findmode(Sampledata$Return)  #0

library(modeest)
mlv(Sampledata$Return, method="mfv")  #0


# Finding Summary
summary(Sampledata$Volume)

#Finding Moment
library(e1071)

#Finding Kurtosis
kurtosis(Sampledata$Volume)

#Finding Skewness
skewness(Sampledata$Volume)

#Finding Correlation
library(Hmisc)
x<-Sampledata[,2:5]
head(x)

rcorr(as.matrix(x), type="pearson")
?rcorr
rcorr(as.matrix(women))
rcorr(as.matrix(mtcars[1:5]))


#Finding autocorrelation plot
acf(Sampledata$Volume)

#Finding partial aoto correlation
pacf(Sampledata$Volume)

# Finding cross correlation
ccf(Sampledata$Volume,Sampledata$High, main = "ccf plot")
