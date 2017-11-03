install.packages("xlsx")
library(xlsx)

desktop <- "C:/users/renee/desktop/Coursera_Hollie" #change this to the folder where you downloaded the excel file of names
setwd(desktop)

colIndex <- 7:15
rowIndex <- 17:23
dat <- read.xlsx("NGAP.xlsx",sheetIndex = 1,colIndex=colIndex, rowIndex = rowIndex)
dat

colnames(dat)

sum(dat$Zip*dat$Ext,na.rm=T)
