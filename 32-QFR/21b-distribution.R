#Normal Distribution

#Chapter-2

#Importing Data : check the location or use file.choose
Sampledata = read.csv("./32-QFR/DataChap2.csv")
#Sampledata = read.csv(file.choose())
head(Sampledata)
#flag and sentiments are dummy variable for analysis

# Normal dist- Norm
y <- dnorm(Sampledata$Return, mean = mean(Sampledata$Return), sd = sd(Sampledata$Return, na.rm = FALSE))
Sampledata$Return
y   #data generated

plot(x=Sampledata$Return,y=y)

# Normal dist- pnorm
#pnorm - cumulative distribution function
pnorm(.02, mean = mean(Sampledata$Return), sd = sd(Sampledata$Return, na.rm = FALSE), lower.tail = F)
#16% chance of getting return greater than 2%
?pnorm

# Normal dist- qnorm
qnorm(0.159837, mean = mean(Sampledata$Return), sd = sd(Sampledata$Return, na.rm = FALSE),lower.tail=FALSE)
#for probability .16, return expected is 2%

# Normal dist- rnorm
rnorm(5, mean = mean(Sampledata$Return), sd = sd(Sampledata$Return, na.rm = FALSE))

#lognormal----

# logNormal dist- dlnorm
head(Sampledata[1:6])
y <- dlnorm(Sampledata$Volume, meanlog = mean(Sampledata$Volume), sdlog = sd(Sampledata$Volume, na.rm = FALSE))

plot(x=Sampledata$Volume,y=y)

# logNormal dist- plnorm
y <- plnorm(Sampledata$Volume, meanlog = mean(Sampledata$Volume), sdlog = sd(Sampledata$Volume, na.r=FALSE))
plot(Sampledata$Volume,y)

#Poisson dist----
ppois(15, lambda=10)


#Uniform dist----
runif(10, min=1, max=5)
