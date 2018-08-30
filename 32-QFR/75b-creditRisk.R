#Credit Risk  - Quantitative Finance - P217(Ch-7)


#load data from library: install lib if reqd
data("GermanCredit",package="caret")
GermanCredit
names(GermanCredit)

LRData = GermanCredit[, 1:10]
names(LRData)
str(LRData)
#Target Variable  Class
table(LRData$Class)
#Good is non-defaulter, Bad-Defaulter
summary(LRData)
nrow(LRData)
sum(is.na(LRData))  #no missing values


#Prepare Data
set.seed(100)
library(caTools)
#split data to train and test based on Class variable
res = sample.split(LRData$Class, 0.6)
head(res)  #T & F
Train = subset(LRData, res==TRUE)  #put T values into Train set
Test = subset(LRData, res==F)  #put F values into Test set

#check the distribution
nrow(Train); nrow(Test)
(t1= rbind(table(Train$Class), table(Test$Class)))
addmargins(t1)
head(Train)
      
#Data Cleaning to be done if reqd

#See Relationships
library(corrplot)
corrplot(cor(Train[1:5]), method='circle')

#Create Model
lgfit = glm(Class ~ . , data = Train, family ="binomial")
summary(lgfit)

#select Significant Variables Stepwise
library(tidyverse)
lgfit2 <- glm(Class ~ . , data = Train, family ="binomial") %>%
  stepAIC(trace = T)  #trace=F will not display output of cmd
summary(lgfit2)

lgfit3 <- glm(Class ~ Duration + InstallmentRatePercentage + Age , data = Train, family ="binomial")
summary(lgfit3)
#all are significant now

#Model Accuracy
predict(lgfit3, newdata = Train, type='response')
Train$predicted.risk = predict(lgfit3, newdata = Train, type='response')
(Train$predicted.risk >= 0.5)
(table(Train$Class, as.numeric(Train$predicted.risk >= 0.5)))
#this confusion matrix 0->0, 1->1 should have happened

(t1= table(Train$Class, ifelse(Train$predicted.risk >= 0.5,"Good","Bad")))
#this confusion matrix 0->0, 1->1 should have happened


table(Train$Class); table(ifelse(Train$predicted.risk >= 0.5,"Good","Bad"))
as.numeric(Train$Class) == as.numeric(Train$predicted.risk >= 0.5)
mean(as.numeric(Train$Class) == as.numeric(Train$predicted.risk >= 0.5))

caret::confusionMatrix(t1)

#what should the partitioning prob : ROCR curve
library(ROCR)
#Train$predicted.class = factor(ifelse(Train$predicted.risk >= 0.5,"Good","Bad"))

str(Train)
pred = prediction(Train$predicted.risk, Train$Class)
pred
as.numeric(performance(pred, "auc")@y.values)  #67.9% accuracy

#Plot ROC Curve
pred = prediction(Train$predicted.risk, Train$Class)
ROCperf = performance(pred, "tpr","fpr")
plot(ROCperf)

#do it for Test Data also
Test$predicted.risk = predict(lgfit3, newdata = Test, type='response')
pred_Test = prediction(Test$predicted.risk, Test$Class)
(performance(pred_Test, "auc")@y.values)  #58% accuracy
ROCperf_Test = performance(pred_Test, "tpr","fpr")
plot(ROCperf_Test)


#ROC
#https://stats.stackexchange.com/questions/132777/what-does-auc-stand-for-and-what-is-it
