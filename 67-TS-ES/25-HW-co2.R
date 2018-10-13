#Holt Winters


m <- HoltWinters(co2)
p <- predict(m, 50, prediction.interval = TRUE)
co2
p
plot(m, p)
