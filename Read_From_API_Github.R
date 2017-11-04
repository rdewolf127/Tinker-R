library(httr)
library(httpuv)
library(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   
                   key = "ed4fad3d44ea3aa69b2d",
                   
                   secret = "0a43a33279730c6ffc910f503de7b59c9d4faa7b")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)

content(req)

json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[,'name']
json2[12,]
json2[12,'created_at']




