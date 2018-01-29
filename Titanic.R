#install.packages('Stat2Data') #installs the package the dataset is located in
library(Stat2Data) #calls the package
data(Titanic) #loads the data

#Show the number of records in the dataset along with the number of attributes, their data types and some sample values 
head(Titanic)
str(Titanic)#Show the descriptive statistics for the Age variable in the dataset (the other values are categorical)
summary(Titanic$Age)

#replace missing Age values with mean age
Titanic$Age[which(is.na(Titanic$Age))] <- mean(Titanic$Age, na.rm = TRUE)

#make sure the NA's are gone
summary(Titanic$Age)

#install the plyr package to do some calcualtions
#install.packages('plyr')
library(plyr)

#get frequency tables for the other fields
count(Titanic, "PClass")
count(Titanic, "Sex")
count(Titanic, "Survived")

#view and drop the record with PClass value '*' and check that the record was dropped
Titanic[Titanic['PClass']=='*']
Titanic = Titanic[Titanic$PClass != '*',]
str(Titanic)

#Check for missing values in the other fields
length(Titanic[which(is.na(Titanic$PClass))])
length(Titanic[which(is.na(Titanic$Sex))])
length(Titanic[which(is.na(Titanic$Survived))])

#install and load ggplot to visualize
#install.packages('ggplot2')
library(ggplot2)

#plot the distribution of Age in a histogram
qplot(Titanic$Age, geom="histogram", bins=10)

#plot the distribution of Age in a boxplot
ggplot(Titanic, aes(y=Age, x="")) + geom_boxplot()

#test for normality, skew and kurtosis
shapiro.test(Titanic$Age)
#install.packages('moments')
library(moments)
kurtosis(Titanic$Age)
skewness(Titanic$Age)

#create a new field that indicates whether a passenger is a child or an adult
Titanic$AgeGroup[Titanic$Age >= 18] <- 1 #adult
Titanic$AgeGroup[Titanic$Age < 18] <- 2 #child

#make it a factor
Titanic$AgeGroup <- factor(Titanic$AgeGroup, levels = c(1,2), labels = c("adult", "child"))

#check that it worked
str(Titanic)

#Make Survived a factor and calc the rate of survival in a barplot
Titanic$SurvivedFactor <- factor(Titanic$Survived, levels = c(0,1), labels = c("No", "Yes"))
ggplot(data=Titanic, aes(x=SurvivedFactor, weight=1/nrow(Titanic))) + 
  geom_bar() + scale_y_continuous(name="Percent ")

#Find out how many survivors there were
Survived = Titanic[Titanic$Survived == 1,]
str(Survived)

#create some bar plots around survival
ggplot(data=Titanic, aes(x=PClass, weight=1/nrow(Titanic['Survived']==1))) + 
  geom_bar() + scale_y_continuous(name="Percent ")
ggplot(data=Titanic, aes(x=Sex, weight=1/nrow(Titanic['Survived']==1))) + 
  geom_bar() + scale_y_continuous(name="Percent ")
ggplot(data=Titanic, aes(x=AgeGroup, weight=1/nrow(Titanic['Survived']==1))) + 
  geom_bar() + scale_y_continuous(name="Percent ")


#Look at survival across the categories
count(Titanic, c("AgeGroup", "Survived"))
count(Titanic, c("PClass", "Survived"))
count(Titanic, c("Sex", "Survived"))
