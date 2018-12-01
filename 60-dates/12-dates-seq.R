#Create Sequence of Dates

#Next day after certain date
as.Date('2018-04-29') + 1
#Sequence of Dates
as.Date('2018-09-16') + 1:15
#alternative Dates
as.Date('2018-09-16') + seq(1,10,2)


#system date
Sys.Date()
#next 15 days after todays date
Sys.Date() + 1:15

##increment/ decrement dates 
(startdt = as.Date("2018-12-01", format="%Y-%m-%d"))
(next20days = startdt + 0:19) # start : 20 days course incl start date
startdt - 1
#20 days course to end on 01-Dec-18
(prev20days = startdt - c(0:19)) # before : 20 days course
rev(prev20days)
