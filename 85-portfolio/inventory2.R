
#inventory
#https://bookdown.org/jeffreytmonroe/business_analytics_with_r7/operations.html

#This can be modeled with a LP with the following elements:

  Decision variables in the form  
x
i
j
, representing units transported from origin  
i
to destination  
j
.

An objective function with cost coefficients equal to  
c
i
j
.

Two sets of constraints: a less or equal set of constraints for each origin, limiting the units to be transported, and a greater of equal set of constraints representing the demand of each destination must be covered.

library(lpSolve)

obj.fun <- c(8,6,3,2,4,9)

m <- 2
n <- 3

constr <- matrix(0, n+m, n*m)

for(i in 1:m){
  for(j in 1:n){
    constr[i, n*(i-1)+j] <- 1
    constr[m+j, n*(i-1)+j] <- 1
  }
}

constr.dir <- c(rep("<=", m), rep(">=", n))
rhs <- c(70,40,40,35,25)

####Solving the LP Model
prod.trans <- lp("min", obj.fun, constr, constr.dir, rhs, compute.sens = TRUE)
print(prod.trans)
prod.trans
####LP Solution
prod.trans$obj.val
sol <- matrix(prod.trans$solution, m, n, byrow=TRUE)
prod.trans$duals

####Sensitivity Analysis of LP
prod.trans$duals.from
prod.trans$duals.to
prod.trans$sens.coef.from
prod.trans$sens.coef.to

