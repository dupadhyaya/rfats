#Chapter - 7 Fraud Detection

data("GermanCredit",package="caret")

#subset data by selecting only few columns
FraudData<-GermanCredit[,1:10]
str(FraudData)
head(FraudData)

(len = dim(FraudData)[1])

train = sample(1:len , 0.8*len)

TrainData = FraudData[train,]
TestData = FraudData[-train,]

library(randomForest)
fraud_model = randomForest( Class ~ . , data=TrainData, ntree=50, proximity=TRUE)
print(fraud_model)

#Plot errors for trees
plot(fraud_model)
#importance of each variable
importance(fraud_model)

TestPred = predict(fraud_model, newdata=TestData)

table(TestPred, TestData$Class)
