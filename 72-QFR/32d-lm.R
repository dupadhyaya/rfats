#Feature selection - Pg 80
#find highly correlated stocks : correlated stocks need to be removed

DataMR = read.csv("./32-QFR/DataForMultipleRegression.csv")
head(DataMR)

correlationMatrix<- cor(DataMR[,1:4])
correlationMatrix

#StockYPrice - DV, others IV
#Stepwise Var Selection -----
library(MASS)  # for stepwise
MultipleR.lm = lm(StockYPrice ~ StockX1Price + StockX2Price + StockX3Price + StockX4Price, data=DataMR)

step <- stepAIC(MultipleR.lm, direction="both")
step$anova 
# see the final model which tells the variable to be selected for LM

# Variable Selection by cls -----

library(mlbench)
library(caret)
DataVI = read.csv("./32-QFR/DataForMultipleRegression1.csv")
head(DataVI)

#from caret - back Feature selection
control<- rfeControl(functions=rfFuncs, method="cv", number=10)
control
Output <- rfe(x=DataVI[,1:4], y=DataVI[,0:1], sizes=c(1:4), rfeControl=control)
predictors(Output)
plot(Output, type=c("g", "o"))
#accuracy of different variable sizes
