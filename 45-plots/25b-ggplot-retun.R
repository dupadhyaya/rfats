#Plots for TS and Financial Data
#Moving Average


library(ggplot2)

library(quantmod)
my.df <- getSymbols("HDFC.NS", src = "yahoo", from = "2013-01-01", to = "2017-06-01", auto.assign = FALSE)
sum(is.na(my.df))
#my.df = my.df[complete.cases(my.df)]  #removal may not draw plots
head(my.df)
class(my.df)
dim(my.df)
names(my.df)

#return
my_ret <- diff(log(my.df[,6]))
my_ret <- my_ret[-1,]

#using quantmod
Op(my.df)
Cl(my.df)
Ad(my.df)
#Hi(), Lo() and Vo(), for maximum and minimum prices and volume of transactions.
Hi(my.df)
Lo(my.df)
Vo(my.df)

#return
dailyReturn(my.df)
weeklyReturn(my.df)
monthlyReturn(my.df)
quarterlyReturn(my.df)
yearlyReturn(my.df)

#basic stats
summary(my_ret)
sd(my_ret)

#
ggplot(my_ret, aes(x = index(my_ret), y = my_ret)) + geom_line(color = "deepskyblue4") +  ggtitle("Stock returns series") +  xlab("Date") + ylab("Return") +  theme(plot.title = element_text(hjust = 0.5)) + scale_x_date(date_labels = "%b %y", date_breaks = "6 months")


#-----
my_ret17 <- subset(my_ret, index(my_ret) > "2017-01-01")

ggplot(my_ret17, aes(x = index(my_ret17), y = my_ret17)) +  geom_line(color = "deepskyblue4") +  ggtitle("Stock returns series in 2017") + xlab("Date") + ylab("Return") +  theme(plot.title = element_text(hjust = 0.5)) + scale_x_date(date_labels = "%b %y", date_breaks = "1 months")


#-----
#https://lamfo-unb.github.io/2017/07/22/intro-stock-analysis-1/