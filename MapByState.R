#install.packages('ggmap')
library(ggmap)

#load in your data that is summarized by state
mydata <- read.csv('c:/users/renee/desktop/srasbystate.csv', colClasses = c("character", "numeric"))
head(mydata)

#load in the state lat/lon file
statelatlon <- read.csv('c:/users/santo/github/DataVisualization611/DataVisualization611/statelatlon.csv')
head(statelatlon)

mydata <- merge(mydata, statelatlon, by="State")
head(mydata)

#drop Hawaii and Alaska to tighten the map 
mydata = mydata[mydata$State != "Alaska",]
mydata = mydata[mydata$State != "Hawaii",]

#get the center of the US from Google Maps
usa_center = as.numeric(geocode("United States"))
USAMap = ggmap(get_googlemap(center=usa_center, scale = 2, zoom =4), extent = "normal")

#plot it
USAMap+
  geom_point(aes(x=Longitude, y=Latitude), data=mydata, col="purple", alpha=0.4,
             size=mydata$SRARatio) 
