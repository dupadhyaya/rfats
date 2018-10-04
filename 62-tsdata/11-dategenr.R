# Date generation

#by Years
seq(as.Date("1910/1/1"), as.Date("1999/1/1"), "years")
seq(as.Date("1910/1/1"), as.Date("1999/1/1"), "1 years")
seq(as.Date("1910/1/1"), as.Date("1999/1/1"), "2 years")
seq(as.Date("1910/1/1"), as.Date("1999/1/1"), "3 years")




## by month
seq(as.Date("2000/1/1"), by = "month", length.out = 12)
seq(as.Date("2000/1/1"), by = "1 month", length.out = 12)
seq(as.Date("2000/1/1"), by = "2 month", length.out = 12)
seq(as.Date("2000/1/1"), as.Date("2003/1/1"), by = "2 month")



## quarters
seq(as.Date("2000/1/1"), as.Date("2003/1/1"), by = "quarter")
seq(as.Date("2000/1/1"), as.Date("2003/1/1"), by = "2 quarter")
seq(as.Date("2000/1/1"), by = "2 quarter", length.out=5)


## days
seq(as.Date("2000/1/1"), as.Date("2002/1/1"), by = "day")
seq(as.Date("2000/1/1"), as.Date("2002/1/1"), by = "2 day")
seq(as.Date("2000/1/1"), by = "3 day", length.out=10)




## find all 7th of the month between two dates, the last being a 7th.
st <- as.Date("1998-12-17")
en <- as.Date("2000-1-7")
ll <- seq(en, st, by = "-1 month")
rev(ll[ll > st & ll < en])
