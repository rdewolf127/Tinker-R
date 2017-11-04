library(httr)
library(httpuv)
library(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   
                   key = "keyfromapp",
                   
                   secret = "secretfromapp")

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




