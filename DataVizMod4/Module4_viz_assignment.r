#load required R packages (need to be installed first)
require(sp) 
require(rgdal) 
require(ggplot2) 
require(mapproj)
require(plyr)
require(ggsn)
require(sf)

#load data
geom <- readOGR("C:/Users/santo/github/Tinker-R/DataVizMod4/cb_2016_36_tract_500k_NYC.shp")     #census tracts geometries
attr <- read.csv("C:/Users/santo/github/Tinker-R/DataVizMod4/ACS_16_5YR_S0701_with_ann_AH_v2.csv", header = TRUE) #attributes from census

#join attribute data to geometries
geom@data$id <- rownames(geom@data)   #create an identifier for each census block (running number)
geoforti <- fortify(geom)             #create fortify object 
geoforti <- join(geoforti, geom@data, by="id")    #join geometries to fortify object
geoforti <- merge(geoforti, attr, by.x="GEOID", by.y="GEO.id2", all.x=T, a..ly=F) #merge census attributes with fortify object

# create the map layers
ggp <- ggplot(data=geoforti, aes(x=long, y=lat, group=group))   #create ggplot object
ggp <- ggp + geom_polygon(aes(fill=as.numeric(HC05_EST_VC05)))         # draw polygons
ggp <- ggp + geom_path(color="grey", linestyle=2)  # draw boundaries
ggp <- ggp + coord_equal() + ggsn::scalebar(geoforti, dist = 5, st.size=3, height=0.01, dd2km = TRUE, model = 'WGS84')
ggp <- ggp + scale_fill_gradient(low = "#ffffcc", high = "#ff4444", 
                                 space = "Lab", na.value = "grey50",
                                 guide = "colourbar") # specify colors
ggp <- ggp + labs(title="New York")
ggp <- ggp + guides(fill=guide_legend(title="Moved From Abroad 18-24 Years"))
ggp <- ggp + north(geoforti)

# render the map
print(ggp)

# create the map layers
ggp <- ggplot(data=geoforti, aes(x=long, y=lat, group=group))   #create ggplot object
ggp <- ggp + geom_polygon(aes(fill=as.numeric(HC05_EST_VC06)))         # draw polygons
ggp <- ggp + geom_path(color="grey", linestyle=2)  # draw boundaries
ggp <- ggp + coord_equal() + ggsn::scalebar(geoforti, dist = 5, st.size=3, height=0.01, dd2km = TRUE, model = 'WGS84')
ggp <- ggp + scale_fill_gradient(low = "#ffffcc", high = "#ff4444", 
                                 space = "Lab", na.value = "grey50",
                                 guide = "colourbar") # specify colors
ggp <- ggp + labs(title="New York")
ggp <- ggp + guides(fill=guide_legend(title="Moved From Abroad 25-34 Years"))
ggp <- ggp + north(geoforti)

# render the map
print(ggp)

# create the map layers
ggp <- ggplot(data=geoforti, aes(x=long, y=lat, group=group))   #create ggplot object
ggp <- ggp + geom_polygon(aes(fill=as.numeric(HC05_EST_VC07)))         # draw polygons
ggp <- ggp + geom_path(color="grey", linestyle=2)  # draw boundaries
ggp <- ggp + coord_equal() + ggsn::scalebar(geoforti, dist = 5, st.size=3, height=0.01, dd2km = TRUE, model = 'WGS84')
ggp <- ggp + scale_fill_gradient(low = "#ffffcc", high = "#ff4444", 
                                 space = "Lab", na.value = "grey50",
                                 guide = "colourbar") # specify colors
ggp <- ggp + labs(title="New York")
ggp <- ggp + guides(fill=guide_legend(title="Moved From Abroad 35-44 Years"))
ggp <- ggp + north(geoforti)

# render the map
print(ggp)

# create the map layers
ggp <- ggplot(data=geoforti, aes(x=long, y=lat, group=group))   #create ggplot object
ggp <- ggp + geom_polygon(aes(fill=as.numeric(HC05_EST_VC08)))         # draw polygons
ggp <- ggp + geom_path(color="grey", linestyle=2)  # draw boundaries
ggp <- ggp + coord_equal() + ggsn::scalebar(geoforti, dist = 5, st.size=3, height=0.01, dd2km = TRUE, model = 'WGS84')
ggp <- ggp + scale_fill_gradient(low = "#ffffcc", high = "#ff4444", 
                                 space = "Lab", na.value = "grey50",
                                 guide = "colourbar") # specify colors
ggp <- ggp + labs(title="New York")
ggp <- ggp + guides(fill=guide_legend(title="Moved From Abroad 45-54 Years"))
ggp <- ggp + north(geoforti)

# render the map
print(ggp)



