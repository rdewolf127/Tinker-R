install.packages("XML")
library(XML)

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

zips <- xpathSApply(rootNode, "//zipcode", xmlValue) 
zips

sum(zips == "21231")


