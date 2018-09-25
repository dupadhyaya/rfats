#Plots for TS and Financial Data


x11()
plot(1:10)

library(ggplot2)

library(quantmod)
my.df <- getSymbols("SBIN.NS", src = "yahoo", from = "2013-01-01", to = "2017-06-01", auto.assign = FALSE)
head(my.df)
class(my.df)
dim(my.df)
names(my.df)

head(rownames(my.df))
my.df[,6]
ggplot(my.df, aes(x = index(my.df), y = my.df[,6])) + geom_line(color = "darkblue") + ggtitle("Stock prices series") + xlab("Date") + ylab("Price") + theme(plot.title = element_text(hjust = 0.5)) + scale_x_date(date_labels = "%b %y", date_breaks = "6 months")


qplot(data = my.df,  x = index(my.df), y = my.df[,6], geom = 'line', 
      xlab = 'Dates', lab = 'Adjusted closing prices')

p <- ggplot(data = my.df, aes(x = index(my.df), y = my.df[,6]))
p <- p + geom_line()
p <- p + labs(x = 'Dates', y = 'Adjusted closing prices')
print(p)

