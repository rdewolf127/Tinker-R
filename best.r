coursera <- "C:/users/renee/desktop/coursera_hollie" #change this to the folder where you downloaded the files
setwd(coursera) #this just changes the working directory to the place where the files are
outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character") #this reads in the file
colnames(outcomes) #view the column names
head(outcomes) #view the first 5 rows of data


#rename the three outcomes we want to use to easier names so we can call them by name
names(outcomes)[23]<-"pneumonia" 
names(outcomes)[11]<- "heart_attack" 
names(outcomes)[17]<-"heart_failure" 

#change the data type of the outcomes columns to numeric so we can do calculations on them
outcomes[,"pneumonia"] <- as.numeric(outcomes[,"pneumonia"])
outcomes[,"heart_attack"] <- as.numeric(outcomes[,"heart_attack"])
outcomes[,"heart_failure"] <- as.numeric(outcomes[,"heart_failure"])

#build the function to take a state name and an outcome and return the state with the best(lowest) value for that outcome
best <- function(state,outcome) {  
  #create lists of valid states and outcomes for your validation
  valid_states <- state.abb
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  #check if your state and outcome are in those lists
  if (state %in% valid_states) {
    if (outcome %in% valid_outcomes){
      #when they are in the lists look at the state and outcome
      if (outcome == "heart attack"){
        curr_outcome <- subset(outcomes, State == state) #limit the table to that state
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_attack, curr_outcome$Hospital.Name, na.last = TRUE),] #sort the table by the outcome
        curr_outcome3 <- na.omit(curr_outcome2) #get rid of NAs
        curr_outcome3[1,2] #Return the first row (the lowest now after the sort) of the second column (which is the hospital name)
      }
      else if (outcome == "heart failure"){
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_failure, curr_outcome$Hospital.Name, na.last = TRUE),]
        curr_outcome3 <- na.omit(curr_outcome2)
        curr_outcome3[1,2]
      }
      else {
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$pneumonia, curr_outcome$Hospital.Name, na.last = TRUE),]
        curr_outcome3 <- na.omit(curr_outcome2)
        curr_outcome3[1,2]
      }
      
    }
    else {
      print("invalid outcome")
    }
  }
  else print("invalid state")
}

#test the function by calling it
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")
