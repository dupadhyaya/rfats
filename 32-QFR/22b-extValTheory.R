#Extreme Value Theory

#Extreme value theory
#install.packages("POT")
library(POT) 

data(ardieres)
head(ardieres)
dim(ardieres)

abc = ardieres[1:10000,]
?clust
events = clust(abc, u = 1.5, tim.cond = 8/365, clust.max = TRUE)
events

par(mfrow = c(2, 2))
mrlplot(events[, "obs"])
diplot(events)
tcplot(events[, "obs"], which = 1)
tcplot(events[, "obs"], which = 2)

#now set threshold point & estimate parameters of GPD

obs = events[,"obs"]
ModelFit = fitgpd(obs, thresh = 5, "pwmu")
ModelFit
