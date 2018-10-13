
library(akima)

year =c(0, 1 ,2 ,3, 4, 5, 6)
cashflow =c( -1350 ,363, 551, 681, 761, 821, 1467)
names(cashflow) = year
cashflow
intDef= .08

#NPV:
period <- 0 ;( length (cashflow) -1)
cashflow.pv <- cashflow /(1+intDef)^period
sum ( cashflow.pv )

#Payback Period:
cashflow.pv.sum <- rep (0,length (cashflow))
for (i in 1:length (cashflow) ) {
  cashflow.pv.sum[i] <- sum (cashflow.pv[1]:cashflow.pv[i])
}
approx (cashflow.pv.sum,period,xout=0.0)

#IRR: ??? part of workshop
polyroot(cashflow) 
  