fileLoc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(fileLoc, destfile = "./quiz.for")

df <- read.fwf("./quiz.for", c(-27,5), header = FALSE, sep = "\t",
         skip = 4)

head(df)
colnames(df)

sum(df$V1)

