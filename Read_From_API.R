#create a dev app for the twitter api to get credentials for access at dev.twitter.com/apps first

#load the httr library
library(httr)

myApp = oauth_app("twitter",
                  key="keyfromapp", secret="secretfromapp")

sig = sign_oauth1.0(myApp, token=
                      "tokenfromapp", token_secret="secretfromapp")

homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

#load the jsonlite library to read the json file
library(jsonlite)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

