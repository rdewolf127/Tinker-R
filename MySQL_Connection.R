#Connect to a MySQL DB
#Windows: Install RTools, MySQL & save Renviron.site first from http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL

install.packages ('RMySQL',type='source')
library(RMySQL)

#connect to the db
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(uscsDb, "show databases;")

#disconnect from the db
dbDisconnect(ucscDb)