#Credit Risk from Git Hub

data(GermanCredit)
LRData<-GermanCredit[,1:10]
str(LRData)
summary(LRData)
set.seed(100)
library(caTools)
res = sample.split(LRData$Class, 0.6)
Train_data = subset(LRData, res == TRUE)
Test_data=subset(LRData,res==FALSE)
lgfit = glm(Class ~. , data=Train_data, family="binomial")
summary(lgfit)
lgfit = glm(Class ~Duration+InstallmentRatePercentage+Age , data=Train_data, family="binomial")
summary(lgfit)
Train_data$predicted.risk = predict(lgfit, newdata=Train_data, type="response")
table(Train_data$Class, as.numeric(Train_data$predicted.risk >= 0.5))

library(ROCR)
pred = prediction(Train_data$predicted.risk, Train_data$Class)
as.numeric(performance(pred, "auc")@y.values)
predict_Train = predict(lgfit, type="response")
ROCpred = prediction(predict_Train, Train_data$Class)
ROCperf = performance(ROCpred, "tpr", "fpr")
plot(ROCperf)

