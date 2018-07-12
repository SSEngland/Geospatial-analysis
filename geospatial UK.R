#plot uk all postcodes
inp <- read.table("G:\\Customer & Marketing\\Customer Analytics\\04. Data Innovation\\ukpostcodes2.csv",header=T, sep=",")

#all details
library(ggplot2)
qplot(xlab="Longitude",ylab="Latitude",main="EH Postcode heatmap",geom="blank",x=inp$longitude,y=inp$latitude,data=inp)  +
  stat_bin2d(bins =200,aes(fill = log1p(..count..))) 
#purely UK area map
UK <- map_data(map = "world", region = "UK") # changed map to "world"
ggplot(data = UK, aes(x = long, y = lat, group = group)) + 
  geom_polygon() +
  coord_map()
#get postcode area/region from UK data, suffix=c(".x",".y")
library(dplyr)
u<-left_join(inp,UK,by=c("longitude"="long","latitude"="lat"),copy=FALSE)

library(ggmap)
UK_map +
  geom_polygon(aes(x=long, y=lat, group=group, fill=order),
               color = "grey50", alpha = .7,
               data =UK)+
  scale_fill_gradientn(colours=terrain.colors(20))


#using ggmap package
library(ggmap)
#Getting specific location
Guildford<-"Guildford"
qmap(Guildford, zoom = 14)



#getting map for the country, normal version, location = c(-2.65, 53.7) with zoom 5 for UK
#location = c(-5.8473961, 54.8505962), zoom = 6.25
#the larger the number of the zoom, the closer to the point
UK_map <- get_map(location = c(-3.65, 54.256), zoom = 6, maptype = "roadmap")
UK_map <- ggmap(ggmap=UK_map, extent = "device", legend = "right")
UK_map + geom_point(data = data.frame(x = -1.81, y = 55.655), aes(x, y), size  = 5)

UK_map <- get_map(location = c(-3.65, 54.256), zoom = 6)
UK_map <- ggmap(ggmap=UK_map, extent = "device", legend = "right")
UK_map + geom_polygon(aes(x=inp$longitude, y=inp$latitude,group=group, fill=inp$id),
             color = "grey50", alpha = .7,
             data =inp)+
  geom_polygon(aes(x=long, y=lat, group=group, fill=poverty),
               color = "grey50", alpha= .7,
               data =subset(map.df, Id1 %in%  c("Berlin", "Bremen")))+
  scale_fill_gradientn(colours=brewer.pal(5,"OrRd"))



#mountain map
UK_map <- get_map(location = c(-3.65, 54.256), zoom = 6, maptype = "terrain")
UK_map <- ggmap(ggmap=UK_map, extent = "device", legend = "right")
#watercolour map, takes a bit longer time
UK_map <- get_map(location = c(-3.65, 54.256), zoom = 6, maptype = "watercolor")
UK_map <- ggmap(ggmap=UK_map, extent = "device", legend = "right")
#black and white, takes a bit longer time
UK_map <- get_map(location = c(-3.65, 54.256), zoom = 6, maptype = "toner")
UK_map <- ggmap(ggmap=UK_map, extent = "device", legend = "right")
#using ggplot2 to plot the actual data
library(ggplot2)
#dot plot
UK_map +  geom_point(aes(x = Longitude, y = Latitude, colour=Postcode.Region,size = X.),  #can use colour = offense, a field in the dataset
             data = csv1) #if added "+theme_bw()" then legend will stay on the white part at the right hand side
#putting size inside aes will make the bubble comparative
#if you put the size outside aes, the size will be according to the data
UK_map + geom_point(aes(x = Longitude, y = Latitude, size = X.), data = csv1, colour = "#30628C")#AXA colour
#adding plotly, plotly doesn't work with this google map but data was plot correctly
p<-UK_map + geom_point(aes(x = Longitude, y = Latitude, size = X.), data = csv1, colour = "#30628C")#AXA colour


library(plotly)
ggplotly(p)

#area plot
UK_map +  stat_bin2d(aes(x = Longitude, y = Latitude, colour=X., fill = X.),
    size = .5, bins = 30, alpha = 1/2,
    data = csv1)

#maps using plotly
#Loading required libraries
library('ggplot2')
library('ggmap')

#List of Countries for ICC T20 WC 2017
ICC_WC_T20 <- c("Australia",
                "India",
                "South Africa",
                "New Zealand",
                "Sri Lanka",
                "England",
                "Bangladesh",
                "Pakistan",
                "West Indies",
                "Ireland",
                "Zimbabwe",
                "Afghanistan")

#extract geo location of these countries
countries <- geocode(ICC_WC_T20)

#map longitude and latitude in separate variables
nation.x <- countries$lon
nation.y <- countries$lat

#using ggplot to plot the world map
mapWorld <- borders("world", colour="grey", fill="lightblue")

#add data points to the world map
q<-ggplot() + mapWorld + geom_point(aes(x=nation.x, y=nation.y) ,color="seagreen4", size=3)

#Using ggplotly() of ployly  to add interactivity to ggplot objects.
ggplotly(q) 




#interactive one, not working at the moment
library(plotly)
g <- list(
  scope = 'uk',
  projection = list(type = 'cyklindrical'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
p <- plot_geo(inp, locationmode = 'Uk-postcode')