#create a dev app for the twitter api to get credentials for access at dev.twitter.com/apps first

#load the httr library
library(httr)

myApp = oauth_app("twitter",
                  key="nRB0tVZs22UUMA7eXkbqIMKeF", secret="ZE3EJIiJqS90ZxxJm2uCxr5m6ZhTTa8UdUh5BcBDxk21LTvIeC")

sig = sign_oauth1.0(myApp, token=
                      "924528038-LgnJrRR260ye4mSsYPFpb9jUN4NSziRR6xwR9u9Y", token_secret="N3QoBJBbH8ElDqxlrU87w54MQrHucm7lhDfhWZ2iCrJiR")

homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

#load the jsonlite library to read the json file
library(jsonlite)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

