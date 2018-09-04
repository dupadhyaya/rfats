
#incomplete

library(ggplot2)
library(stringr)

# get names of functions in ggplot2
fcts <- ls('package:ggplot2')
fcts

# select those that starts with geom_
idx <- str_sub(fcts, 1, 5) == 'geom_'
idx
fcts <- fcts[idx]

# print result
print(fcts)

p <- ggplot(data = my.df, aes(x = index(my.df), y = my.df[,6]))
p <- p + geom_line()
#p <- p + labs(x = 'Dates', y = 'Adjusted closing prices')
print(p)
