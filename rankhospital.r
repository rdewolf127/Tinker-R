#build the function to take a state name and an outcome and return the state with the best(lowest) value for that outcome
rankhospital <- function(state,outcome, rank) {  
  #create lists of valid states and outcomes for your validation
  valid_states <- state.abb
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  #check if your state and outcome are in those lists
  if (state %in% valid_states) {
    if (outcome %in% valid_outcomes){
      #when they are in the lists look at the state and outcome
      if (outcome == "heart attack" & rank == 'best'){
        curr_outcome <- subset(outcomes, State == state) #limit the table to that state
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_attack, curr_outcome$Hospital.Name, na.last = TRUE),] #sort the table by the outcome
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[1,2]
      }
      else if (outcome == "heart attack" & rank == "worst"){
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_attack, curr_outcome$Hospital.Name, na.last = TRUE, decreasing = TRUE),]
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[1,2]
      }
      else if (outcome == "heart attack" & !rank %in% c("worst", "best")){
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_attack, curr_outcome$Hospital.Name, na.last = TRUE),]
        curr_outcome2["rank"] <- rank(curr_outcome2$heart_attack, na.last = TRUE, ties.method = "first")
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[rank,2]
      }
      else if (outcome == "heart failure" & rank == 'best'){
        curr_outcome <- subset(outcomes, State == state) #limit the table to that state
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_failure, curr_outcome$Hospital.Name, na.last = TRUE),] #sort the table by the outcome
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[1,2]
      }
      else if (outcome == "heart failure" & rank == "worst"){
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_failure, curr_outcome$Hospital.Name, na.last = TRUE, decreasing = TRUE),]
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[1,2]
      }
      else if (outcome == "heart failure" & !rank %in% c("worst", "best")){
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_failure, curr_outcome$Hospital.Name, na.last = TRUE),]
        curr_outcome2["rank"] <- rank(curr_outcome2$heart_attack, na.last = TRUE, ties.method = "first")
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[rank,2]
      }
      else if (outcome == "pneumonia" & rank == 'best'){
        curr_outcome <- subset(outcomes, State == state) #limit the table to that state
        curr_outcome2 <- curr_outcome[order(curr_outcome$pneumonia, curr_outcome$Hospital.Name, na.last = TRUE),] #sort the table by the outcome
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[1,2]
      }
      else if (outcome == "pneumonia" & rank == "worst"){
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$pneumonia, curr_outcome$Hospital.Name, na.last = TRUE, decreasing = TRUE),]
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[1,2]
      }
      else {
        curr_outcome <- subset(outcomes, State == state)
        curr_outcome2 <- curr_outcome[order(curr_outcome$heart_pneumonia, curr_outcome$Hospital.Name, na.last = TRUE),]
        curr_outcome2["rank"] <- rank(curr_outcome2$pneumonia, na.last = TRUE, ties.method = "first")
        curr_outcome3 <- na.omit(curr_outcome2)
        result <- curr_outcome2[rank,2]
      }
      result
    }
    else {
      print("invalid outcome")
    }
  }
  else print("invalid state")
}
