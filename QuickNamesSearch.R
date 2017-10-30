desktop <- "C:/users/renee/desktop/" #change this to the folder where you downloaded the csv file of names
setwd(desktop) #this just changes the working directory to the place where the file is
names <- read.csv("samplenames.csv", colClasses = "character") #this reads in the file

#Will show you the column names in the file
colnames(names)

#Will show you the first 5 rows of the file
head(names, 5)

#import a string library to cleanup any weird whitespaces that might be in the fields
library(stringr)

#concatenate lastname and firstname and remove any whitespace
#If r actual firstname and lastname fields are called something different you'll need to change this below or change it in the csv
fullname <- paste(names$LastName, names$FirstName)  
str_replace_all(string=fullname, pattern=" ", repl="") 

#import a library to run a frequency distribution
library(MASS)

#create and print the frequency distribution table  (this will show each name in the table with the number of times it appears.)
fullname.freq = table(fullname)
results <- data.table(results)
print(results)

#sort by name
results_by_name <- results[order(results$fullname),]
print(results_by_name)

#sort by frequency
results_by_freq <- results[order(results$Freq),]
print(results_by_freq)

#If you want to subset to only results that appear more than once 
more_than_once <- subset(results, Freq > 1)
print(more_than_once)

