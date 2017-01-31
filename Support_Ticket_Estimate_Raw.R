library("stats", lib.loc="C:/Program Files/R/R-3.3.0/library")
        
#To predict the number of support tickets a new contract will generate based on the number of users and contract value

#read in the historical support ticket file
tickets <- read.csv("C:/Users/ReneeD/Desktop/Desktop/RegressApp/linear-example-data.csv")

#read the first few rows
head(tickets)

#create scatter plots to view the relationship between the predictor and target variables
plot(tickets$AverageNumberofTickets, tickets$NumberofEmployees)
plot(tickets$AverageNumberofTickets, tickets$ValueofContract)


#build the model
tickets.lm <- lm(AverageNumberofTickets ~ NumberofEmployees + ValueofContract, data = tickets )

#display the regression
summary(tickets.lm)


#print the prediction formula
formula <- as.formula(
  paste0("y ~ ", round(coefficients(tickets.lm)[1],2), "", 
         paste(sprintf(" %+.6f*%s ", 
                       coefficients(tickets.lm)[-1],  
                       names(coefficients(tickets.lm)[-1])), 
               collapse="")
  )
)
formula

#Create a function to use the model to create a prediction using new contract values
prediction <- function(a,b){
  prediction <- coefficients(tickets.lm)[1] + (coefficients(tickets.lm)[2]*a) + (coefficients(tickets.lm)[3]*b)
  return(prediction)}

#Test the prediction formula
prediction(50, 350000)
  

