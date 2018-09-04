#reading using zoo


library(zoo)
#Date,Volume,Adj Close,Return
#12/14/2016,4144600,198.690002,0.272525

data = read.zoo('./32-QFR/DataChap4.csv', header=T, sep=',', format="%m/%d/%Y")
head(data)

# subsetting data

window(data, start=as.Date("2016/11/1"), end = as.Date("2016/11/15"))

#merge Data

#Plotting Data
plot(data$Volume)


#disadvantages  of zoo
#cannot have date classed variables
class(data)
#cannot have arbritary attributes in zoo
