#Chapter - 7 Fraud Detection

data("GermanCredit",package="caret")

head(data)
names(data)
fraudData = data[,1:10]
str(fraudData)
head(fraudData)
