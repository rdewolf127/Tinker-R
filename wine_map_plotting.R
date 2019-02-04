#read in the file
#get ggmap from devtools because package from CRAN isn't up to date
#devtools::install_github("dkahle/ggmap", ref = "tidyup")

library(readr)
library(ggplot2)
library(ggmap)
library(ggalt)

wine_R <- read_csv("C:/Users/santo/github/Tinker-R/wine_R2.csv")

#produce scatterplot colored by country
ggplot(wine_R, aes(x=points, y=price)) + geom_point(aes(color=country))+
  scale_y_continuous("price", breaks = seq(0,350,by = 50))+
  scale_x_continuous("points", breaks = seq(78,96,by = 2))+
  theme_bw() + labs(subtitle="Points vs. Price")

#add fitted line
ggplot(wine_R, aes(points, y=price)) + geom_point(aes(col=country)) + 
  geom_smooth(method="loess", se=F) + 
  scale_y_continuous("price", breaks = seq(0,350,by = 50))+
  scale_x_continuous("points", breaks = seq(78,96,by = 2))+
  theme_bw() +labs(subtitle="Points vs. Price")

#put into matrix by country
ggplot(wine_R, aes(points, price)) + geom_point(aes(color = country)) + 
  scale_y_continuous("price", breaks = seq(0,350,by = 50))+
  scale_x_continuous("points", breaks = seq(78,96,by = 2))+
  theme_bw() + labs(subtitle="Points vs. Price") + facet_wrap( ~ country)

poi_subset <- read_csv("C:/Users/santo/github/Tinker-R/poi_subset.csv")

ggmap::register_google(key = "REDACTED")
ts_center = as.numeric(geocode("Times Square"))

NYCMap2 <- ggmap(get_googlemap(center = ts_center,
                         zoom = 16, scale = 2,
                         maptype ='terrain',
                         color = 'color'))

NYCMap2 + geom_point(aes(x = Longitude, y = Latitude), data = poi_subset, size = 3) + 
  theme(legend.position="bottom")

# Google Road Map
ts_road_map <- qmap("Times Square", zoom=13, source = "google", maptype="roadmap")  

# Google Hybrid Map
ts_hybrid_map <- qmap("Times Square", zoom=13, source = "google", maptype="hybrid")  

ts_places <- c("MARRIOTT MARQUIS HOTEL",
                    "BOWLMOR LANES TIMES SQUARE",
                    "DISCOVERY TIMES SQUARE EXHIBITION CENTER",
                    "HARD ROCK CAFE TIMES SQUARE",
                    "RED STAIRS TIMES SQUARE")

places_loc <- geocode(ts_places) 
as.data.frame(places_loc)

# Plot Google Road Map -------------------------------------
ts_road_map + geom_point(aes(x=lon, y=lat),
                                  data = places_loc, 
                                  alpha = 0.3, 
                                  size = 2, 
                                  color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 1, color = "blue")

# Google Hybrid Map ----------------------------------------
ts_hybrid_map + geom_point(aes(x=lon, y=lat),
                                    data = places_loc, 
                                    alpha = 0.3, 
                                    size = 2, 
                                    color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 1, color = "blue")

#OSM Map
library(OpenStreetMap)
library(maps)
require(maps)
require(ggplot2)
mp <- openmap(c(40.814119593752956,-74.0380305496094),
              c(40.69552753081169,-73.93640701445315),12,"osm")


plot(mp)

#OPen Street Map
library("ggmap")
map <- get_map(location = c(lon[1], lat[2], lon[2], lat[1]),
               source = "osm", zoom = 12)
p <- ggmap(map) +
  geom_point(aes(x=lon, y=lat),
             data = places_loc, 
             alpha = 0.3, 
             size = 2, 
             color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 1, color = "blue")
print(p)



#Bing Map
library(RgoogleMaps)

key <- 'REDACTED'


map1=GetBingMap(center=c(40.75890,-73.98513 ),zoom=13,apiKey=key, 
                verbose=1, destfile="ts.png") 


PlotOnStaticMap(map1)

PlotOnStaticMap(map1,lat=poi_subset$Latitude,lon=poi_subset$Longitude)

