coursera <- "C:/users/renee/desktop/coursera_hollie" #change this to the folder where you downloaded the files
setwd(coursera) #this just changes the working directory to the place where the files are
outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character") #this reads in the file


#rename the three outcomes we want to use to easier names so we can call them by name
names(outcomes)[23]<-"pneumonia" 
names(outcomes)[11]<- "heart_attack" 
names(outcomes)[17]<-"heart_failure" 

#change the data type of the outcomes columns to numeric so we can do calculations on them
outcomes[,"pneumonia"] <- as.numeric(outcomes[,"pneumonia"])
outcomes[,"heart_attack"] <- as.numeric(outcomes[,"heart_attack"])
outcomes[,"heart_failure"] <- as.numeric(outcomes[,"heart_failure"])

rankall <- function(outcome, num ="best"){
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop("invalid outcome")
  }
  else if (outcome == "heart attack") {
    if (num == "best"){
    curr<- outcomes[order(outcomes$State, outcomes$heart_attack),]#sort by state and heart attack outcome
    result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                    Ranks = rank(heart_attack,ties.method = "first", na.last = "keep"))) #rank heart attack deaths by state in asc 
    result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == 1) #create a dataframe with only State. Hospital and Rank for Stores of Rank 1
    result2 <- result1[c("State", "Hospital.Name")] #Drop the Rank column
    result2
    }
    else if (num == "worst") {
    curr<- outcomes[order(outcomes$State, -outcomes$heart_attack),]
    result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(-heart_attack,ties.method = "first", na.last = "keep")))
    result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == 1)
    result2 <- result1[c("State", "Hospital.Name")]
    result2
    }
    else {
    curr<- outcomes[order(outcomes$State, outcomes$heart_attack),]
    result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(heart_attack,ties.method = "first", na.last = "keep")))
    result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == num)
    result2 <- result1[c("State", "Hospital.Name")]
    result2
    }
  }
  else if (outcome == "heart failure") {
    if (num == "best"){
      curr<- outcomes[order(outcomes$State, outcomes$heart_failure, outcomes$Hospital.Name),]#sort by state and outcome
      result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(heart_failure,ties.method = "first", na.last = "keep"))) #rank deaths by state in asc 
      result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == 1) #create a dataframe with only State. Hospital and Rank for Stores of Rank 1
      result2 <- result1[c("State", "Hospital.Name")] #Drop the Rank column
      result2
    }
    else if (num == "worst") {
      curr<- outcomes[order(outcomes$State, -outcomes$heart_failure),]
      result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(-heart_failure,ties.method = "first", na.last = "keep")))
      result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == max(Ranks))
      result2 <- result1[c("State", "Hospital.Name")]
      result2
    }
    else {
      curr<- outcomes[order(outcomes$State, outcomes$heart_failure),]
      result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(heart_failure,ties.method = "first", na.last = "keep")))
      result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == num)
      result2 <- result1[c("State", "Hospital.Name")]
      result2
    }
  }
  else  {
    if (num == "best"){
      curr<- outcomes[order(outcomes$State, outcomes$heart_pneumonia),]#sort by state and outcome
      result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(heart_pneumonia,ties.method = "first", na.last = "keep"))) #rank deaths by state in asc 
      result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == 1) #create a dataframe with only State. Hospital and Rank for Stores of Rank 1
      result2 <- result1[c("State", "Hospital.Name")] #Drop the Rank column
      result2
    }
    else if (num == "worst") {
      curr<- outcomes[order(outcomes$State, -outcomes$pneumonia),]
      result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(-pneumonia,ties.method = "first", na.last="keep")))
      result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == 1)
      result2 <- result1[c("State", "Hospital.Name")]
      result2
    }
    else {
      curr<- outcomes[order(outcomes$State, outcomes$pneumonia),]
      result<-do.call(rbind,lapply(split(curr,curr$State),transform,
                                   Ranks = rank(pneumonia,ties.method = "first",na.last = "keep")))
      result1 <- subset(result[c("State", "Hospital.Name", "Ranks")], Ranks == num)
      result2 <- result1[c("State", "Hospital.Name")]
      result2
    }
  }
}

head(rankall("heart attack", 20),10)
tail(rankall("pneumonia", "worst"),3)
tail(rankall("heart failure"),10)
