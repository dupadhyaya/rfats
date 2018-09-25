#Risk Management C-7
#Value at Risk

#parmetric VaR----
mean = 2
sigma = 4
alpha = .05

(Var_parametric = qnorm(alpha, mean, sigma))

(Var_parametric1 = mean + sigma * qnorm(alpha, 0, 1))

#convert to different Horizon

(alpha_z = qnorm(alpha))

(ES_parametric = mean + sigma * (dnorm(alpha_z)/(1-alpha)))

#Historical VaR ----
#assumption - past repeats itself
library(quantmod)
symbollist = c("FB", "V","JNJ")

getSymbols(symbollist, from ="2016-01-01", to = "2017-01-01")

FB = FB[, "FB.Adjusted", drop=F]
head(FB)

V = V[, "V.Adjusted", drop=F]

JNJ = JNJ[, "JNJ.Adjusted", drop=F]

library(PerformanceAnalytics)
FB_return = CalculateReturns(FB,  method="log")
head(FB_return)
V_return = CalculateReturns(V,  method="log")
JNJ_return = CalculateReturns(JNJ,  method="log")

FB_return = FB_return[-1,]
head(FB_return)
V_return = V_return[-1,]
JNJ_return = JNJ_return[-1,]

FB_V_JNJ_return = cbind(FB_return,V_return,JNJ_return)
head(FB_V_JNJ_return)
sum(is.na(FB_V_JNJ_return))
FB_V_JNJ_return = FB_V_JNJ_return[complete.cases(FB_V_JNJ_return),]

(HVAR = VaR(FB_V_JNJ_return, p=0.95, method="historical"))

(HCVAR = ES(FB_V_JNJ_return, p=0.95, method="historical"))

#error in this code if NA values
VaR(FB_V_JNJ_return, p=0.95,portfolio_method="component")

VaR(FB_V_JNJ_return, p=0.95,portfolio_method="marginal")



### Monte Carlo Simulation----
Sample_Size = 2000
set.seed(2345)
Z = rnorm(Sample_Size)
head(Z)
mean = .20 ; sigma = .25; deltat = .08333

returns = mean * deltat + sigma * Z * sqrt(deltat)
head(returns)

hist(returns, breaks = 50)
(Mean_new = mean(returns) * 12) #close to mean selected

(std_new = sd(returns)*(12)^(.5)) #close to stddev selected

VaR(returns, p = 0.95, method="historical")
