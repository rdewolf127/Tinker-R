#Connect to a MySQL DB
#Windows: Install RTools, MySQL & save Renviron.site first from http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL

install.packages ('RMySQL',type='source')
library(RMySQL)

#connect to the server
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")

#show all dbs on the server
result <- dbGetQuery(uscsDb, "show databases;")

#disconnect from the server
dbDisconnect(ucscDb)

#connect to a specific db on the server
hg19 <- dbConnect(MySQL(),user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")

#list all tables in the db
allTables <- dbListTables(hg19)

#get the number of tables in the db
length(allTables)

#get list of all fields in a specific table
dbListFields(hg19, "affyU133Plus2")

#query the table
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

#create a df from extracted data
affydata <- dbReadTable(hg19, "affyU133Plus2")