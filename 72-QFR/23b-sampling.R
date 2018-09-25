#Sampling

head(Sampledata)

# Sampling-Random
sample(1:5, 3)
#without replacement; uniques samples
RandomSample = Sampledata[sample(1:nrow(Sampledata), 10, replace=FALSE),]
RandomSample
#with replacement; sample can be selected again
RandomSample = Sampledata[sample(1:nrow(Sampledata), 10, replace=TRUE),]
RandomSample
duplicated(RandomSample) # run gain, sometimes duplicates may not come

# Sampling-Strata
table(Sampledata$Flag,Sampledata$Sentiments)
head(Sampledata[c('Flag','Sentiments')])

library(sampling)
Stratsubset = strata(Sampledata,c("Flag","Sentiments"), size=c(6,5,4,3), method="srswor")
Stratsubset
head(Sampledata)



#stratified Sampling
## Sample data
library(data.table)
set.seed(1)
(n <- 1e4)  #10000
d <- data.table(age = sample(1:5, n, TRUE), 
                lc = rbinom(n, 1 , .5),
                ants = rbinom(n, 1, .7))
d
table(d$age, d$lc)

#For stratified, you basically specify the dataset, the stratifying columns, and an integer representing the size you want from each group OR a decimal representing the fraction you want returned (for example, .1 represents 10% from each group)
library(splitstackshape)
set.seed(1)
table(d$age)
(st1 = stratified(d, c("age"), 4))
table(d$lc)
(st2 = stratified(d, c("lc"), 2))

table(d$age, d$lc) 
set.seed(1)
out <- stratified(d, c("age", "lc"), 5)
#50 samples from 1 to 5 cat of age and 2 cat of 1c
out
head(out)
table(out$age, out$lc)

library(dplyr) #using dplyr
set.seed(1)
out2 <- d %>% group_by(age, lc) %>% sample_n(30)
out2
out1==out2
d
table(d$age)
#3 from stata1, 4 from strat2 ...
out3 = strata(d,c("age"), size=c(3,5,2,4,1), method="srswor")
out3
table(out3$Stratum)
