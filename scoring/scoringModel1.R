#Scoring Model
#https://stats.stackexchange.com/questions/175654/how-to-build-scoring-model-scorecard-from-logistic-regression


library(OneR) # for bin and eval_model function
?bin
mtcars_bin <- bin(mtcars)
head(mtcars_bin)
mtcars_bin

m <- glm(am ~ hp + wt, data = mtcars_bin, family = binomial)
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
coefficients(m) #points for ranges

(prediction <- round(predict(m, type = 'response', mtcars_bin)))

eval_model(prediction, mtcars_bin$am)

coefficients(m) * 20/log(2)
