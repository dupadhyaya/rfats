### Fraud detection from Git Hub
#https://github.com/PacktPublishing/Learning-Quantitative-Finance-with-R/blob/master/Chapter07/Chapter%207%20Code


data(GermanCredit)
FraudData<-GermanCredit[,1:10]
head(FraudData)
len<-dim(FraudData)[1]
train<- sample(1:len , 0.8*len)
TrainData<-FraudData[train,]
TestData<-FraudData[-train,]

library(randomForest)
fraud_model <- randomForest(Class~.,data=TrainData,ntree=50,proximity=TRUE)
print(fraud_model)
plot(fraud_model)
importance(fraud_model)
TestPred<-predict(fraud_model,newdata=TestData)
table(TestPred, TestData$Class)
