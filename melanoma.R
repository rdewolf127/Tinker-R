install.packages('boot') #installs the package the dataset is located in
library(boot) #calls the package
data(melanoma) #loads the data

head(melanoma)
str(melanoma)

#descriptive statistics on quantitative variables
summary(melanoma$age)
summary(melanoma$thickness)
summary(melanoma$time) # of days alive since operation

library(plyr)

#frequencies on categorical variables (looking at age both ways)
count(melanoma, "status")  # 1 = died from melanoma, 2 = still alive, 3 = died from other causes
count(melanoma, "sex")
count(melanoma, "age") # age at time of operation
count(melanoma, "year") # year of operation
count(melanoma, "ulcer")

#make status a factor
melanoma$status_factor <- factor(melanoma$status, levels = c(1,2,3), labels = c("died_melanoma", "alive", "died_other"))

#make sex a factor 
melanoma$sex_factor <- factor(melanoma$sex, levels = c(0,1), labels = c("female", "male"))

#make ulcer a factor
melanoma$ulcer_factor <- factor(melanoma$ulcer, levels = c(0,1), labels = c("absent", "present"))

library(ggplot2)

#plot age
qplot(melanoma$age, geom="histogram", bins=10)
ggplot(melanoma, aes(y=age, x="")) + geom_boxplot()

#normality on age
shapiro.test(melanoma$age)
#install.packages('moments')
library(moments)
kurtosis(melanoma$age)
skewness(melanoma$age)

#bin age to make it a factor
install.packages('binr')
library('binr')

bins.quantiles(melanoma$age, 5,5)

melanoma$agegroup[(melanoma$age >= 4 & melanoma$age <=38)] <- 1 #4 - 38
melanoma$agegroup[(melanoma$age >= 39 & melanoma$age <=49)] <- 2 #39 - 49
melanoma$agegroup[(melanoma$age >= 50 & melanoma$age <=58)] <- 3 #50 - 58
melanoma$agegroup[(melanoma$age >= 59 & melanoma$age <=67)] <- 4 #59 - 67
melanoma$agegroup[(melanoma$age >= 68 & melanoma$age <=95)] <- 5 #68 - 95

#make it a factor
melanoma$agegroup <- factor(melanoma$agegroup, levels = c(1,2,3,4,5), labels = c("4-38", "39-49", "50-58", "59-67", "68-95"))

#plot thickness
qplot(melanoma$thickness, geom="histogram", bins=10)
ggplot(melanoma, aes(y=thickness, x="")) + geom_boxplot()

#normality on thickness
shapiro.test(melanoma$thickness)
kurtosis(melanoma$thickness)
skewness(melanoma$thickness)

#bin thickness to make it a factor
bins.quantiles(melanoma$thickness, 5,5)

melanoma$thickness_factor[(melanoma$thickness >= .1 & melanoma$thickness <=.81)] <- 1 #4 - 38
melanoma$thickness_factor[(melanoma$thickness >= .97 & melanoma$thickness <=1.45)] <- 2 #4 - 38
melanoma$thickness_factor[(melanoma$thickness >= 1.53 & melanoma$thickness <=2.58)] <- 3 #4 - 38
melanoma$thickness_factor[(melanoma$thickness >= 2.74 & melanoma$thickness <=4.19)] <- 4 #4 - 38
melanoma$thickness_factor[(melanoma$thickness >= 4.51 & melanoma$thickness <=17.42)] <- 5 #4 - 38

#make it a factor
melanoma$thickness_factor <- factor(melanoma$thickness_factor, levels = c(1,2,3,4,5), labels = c(".81", "1.45", "2.58", "4.19", "17.42"))

#add a patientid field
melanoma$patientid <- seq.int(nrow(melanoma))

#create a new dataframe with only the patient id and factor variables for analysis
drops <- c("time","status", "sex", "age", "thickness", "ulcer", "year", "patientid")
melanoma_assoc <- melanoma[ , !(names(melanoma) %in% drops)]

#install an association analysis package
install.packages('arules')
library('arules')

#use apriori to run the association analysis
rules <- apriori(melanoma_assoc)
inspect(rules)

#sort by lift and limit to only alive or dead via melanoma patients
rules <- apriori(melanoma_assoc, parameter = list(minlen=2, supp=.005, conf=.8), appearance = list(rhs=c("status_factor=alive", "status_factor=died_melanoma"), default="lhs"), control = list(verbose=F))
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

# find redundant rules
subset.matrix <- is.subset(rules.sorted, rules.sorted, sparse = FALSE)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)

#prune redundant rules
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)
