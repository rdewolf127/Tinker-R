desktop <- "C:/users/renee/desktop/Coursera_Hollie" #change this to the folder where you downloaded the excel file of names
setwd(desktop)

install.packages("data.table")
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./06pid.csv")
dateDownloaded <- date()

DT <- fread("./06pid.csv")

#1
system.time(mean(DT[DT$SEX==1,]$pwgtp15))

system.time(mean(DT[DT$SEX==2,]$pwgtp15))

#2
system.time(rowMeans(DT)[DT$SEX==1])

system.time(rowMeans(DT)[DT$SEX==2])

#3
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

#4
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

#5
system.time(DT[,mean(pwgtp15),by=SEX])

#6
system.time(mean(DT$pwgtp15,by=DT$SEX))
