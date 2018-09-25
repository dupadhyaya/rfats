##ANOVA
#ANOVA is used to determin whether there are any statistically significant differences between the means of 3 or more Indep gps
#for 2 gps we can use t.test

DataANOVA = read.csv("./32-QFR/DataAnova.csv")
head(DataANOVA)
str(DataANOVA)
DataANOVA
boxplot(DataANOVA$Returns ~ DataANOVA$Stock) 

oneway.test(DataANOVA$Returns ~ DataANOVA$Stock, var.equal=TRUE)

#Ho: there is no difference in return of stocks
#p value < 0.05; Reject Ho : Returns not similar

#Feature selection