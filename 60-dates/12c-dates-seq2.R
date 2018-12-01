# sequence of dates

(indepdate = as.Date("1947-08-15"))

#add 30days to each previous date
(days30= indepdate + seq(0,200,30))
length(days30)

as.numeric((Sys.Date() - days30)/365)  #: Years

#by years : from start date to end date
seq(as.Date("2016/1/1"), as.Date("2018/12/1"), by="years")

# find next 5 yrs date from a date
seq(as.Date("2016/1/1"), length.out=5, by="years")

## quarters : 4 qtrs in a year
seq(as.Date("2017/1/1"), as.Date("2018/12/1"), by = "quarter")
seq(as.Date("2017/1/1"), by = "quarter", length.out = 6)


# find next months date from a date 
seq(as.Date("2016/1/1"), as.Date("2018/12/1"), by="months")

## by month : 6 months
seq(as.Date("2017/1/1"), by = "month", length.out = 6)
seq(as.Date("2017/1/1"), by = "month", along.with = c(3,2,43,5,6,7))# pick length of vector

# find next few days after certain date
seq(as.Date("2017/1/1"), by = "days", length.out = 45)


# using  along.with in seq
(x = LETTERS[1:10])
seq(as.Date("2017/1/1"), by = "month", along.with = x)  # 
seq(as.Date("2017/1/1"), by = "quarter", along.with = x)  # 
seq(as.Date("2017/1/1"), by = "month", length.out = length(c(3,2,43))) 
#application- sometimes you have sales data and want to put periodicity


#More selective Dates

#Find 7th of all months between two dates in fwd direction
(dateseq1 = seq(as.Date("2017/1/7"), as.Date("2018/1/7"), by = "1 month"))  # 1 can be made any other integer value

# dates in opposite order : note -2
(dateseq2 = seq(as.Date("2018/1/7"), as.Date("2017/1/7"), by = "-2 month")) 

# then reverse them
rev(dateseq2)# correct the order
format(rev(dateseq2), "%A : %d-%b")

#install.packages("chron")
#another Sequence : using another package : mm-dd-yyyy format
chron::seq.dates("01/01/2010", "12/31/2018", by = "years")
chron::seq.dates("01/01/2018", "12/31/2018", by = "months")
chron::seq.dates("11/01/2018", "12/31/2018", by = "weeks")
chron::seq.dates("12/01/2018", "12/31/2018", by = "days")


#end
