#sushmna - iitg

names1 = c('banana', 'apple', 'investment', 'fd', 'personality', 'skill', 'orange', 'shares')
cat1 = c(1,1,2,2,3,3,1,2)
length(cat1)
length(names1)
df1 = data.frame(names1, cat1)
df1

row.names(df1) = names1
df1
fit = kmeans(df1[,-1],3)
fit$cluster
df1[fit$cluster==1,]
df1[fit$cluster==2,]
df1[fit$cluster==3,]

(group1 = df1[fit$cluster==1,]$names1)
(group2 = df1[fit$cluster==2,]$names1)
(group3 = df1[fit$cluster==3,]$names1)
gp1=as.character(group1)
gp2=as.character(group2)
gp3=as.character(group3)

cat(gp1,file="outfile.txt",append=TRUE)
cat(' ',file="outfile.txt",append=TRUE, sep='\n' )
cat(gp2,file="outfile.txt",append=TRUE)
cat(' ',file="outfile.txt",append=TRUE, sep='\n' )
cat(gp3,file="outfile.txt",append=TRUE)



