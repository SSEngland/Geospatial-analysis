#in the uk shape files, id is the field for postcode area
library(maptools)
# Download a shapefile of postal codes into your working directory
download.file(
  "http://www.opendoorlogistics.com/wp-content/uploads/Data/UK-postcode-boundaries-Jan-2015.zip",
  "postal_shapefile"
)

# Unzip the shapefile
unzip("postal_shapefile")

# Read the shapefile, maptool function
postal <- readShapeSpatial("./Distribution/Areas")
#convert the shape file to plot
library(ggplot2)
uk_shp_df<-fortify(postal, region = "name")
sp_data<-left_join(uk_shp_df,dta,by=c("id"="name"))
#plot the shapre file as a test
ggplot(uk_shp_df,aes(uk_shp_df$long, uk_shp_df$lat, fill=uk_shp_df$id))+
  geom_polygon()+coord_equal()+
  labs(x="longitude",y="latitude",fill="Region \nID")+ggtitle("TEST")
#simple chart with the data
ggplot(sp_data,aes(sp_data$long, sp_data$lat, group=id, fill=sp_data$value))+
  geom_polygon()+coord_equal()+
  labs(x="longitude",y="latitude",fill="Region \nID")+ggtitle("TEST")
#add different colour to the chart
ggplot() +
  geom_polygon(data = sp_data, 
               aes(x = long, y = lat, group = group, fill = sp_data$value), 
               color = "white", size = 0.25) +coord_map()+
  scale_fill_distiller(name="Random \nNo", palette = "YlGn")+
  theme_nothing(legend = TRUE)+
  labs(title="Random number for UK area")
#heatmap
ggplot() +
  geom_polygon(data = sp_data, 
               aes(x = long, y = lat, group = group, fill = sp_data$value), 
               color = "grey", size = 0.25) +coord_map()+  #color is the boundary color for the map
  scale_fill_gradient2(name="Random \nNo",low="chartreuse3",high="red",mid="white",midpoint = 0.5)+
  theme_nothing(legend = TRUE)+
  labs(title="Random number for UK area")

#save map
p2 <- ggplot() +
  geom_polygon(data = sp_data, 
               aes(x = long, y = lat, group = group, fill = sp_data$value), 
               color = "grey", size = 0.25) +coord_map()+  #color is the boundary color for the map
  scale_fill_gradient2(name="Random \nNo",low="red",high="chartreuse3",mid="white",midpoint = 0.5)+
  theme_nothing(legend = TRUE)+
  labs(title="Random number for UK area")

ggsave(p2, file = "map1.png", width = 6, height = 4.5, type = "cairo-png")

#another way to save as pdf
pdf("mymap.pdf")
dev.off()

#-----------------------------------------------------------------------------------------

library(maps)       # Provides functions that let us plot the maps
library(mapdata)    # Contains the hi-resolution points that mark out the countries.
library(sp)
gadm <- readRDS("C:/Users/syick/Documents/postcode/GBR_adm_gdb.zip")

#this method is used when disconnecting from vpn
library(tidyverse)
library(tibble)
library(maptools)
library(raster)
library(plotrix)

# Generate dummy data
dta <-
  tibble(
    name = c(
      "AB",
      "AL",
      "B",
      "BA",
      "BB",
      "BD",
      "BH",
      "BL",
      "BN",
      "BR",
      "BS",
      "CA",
      "CB",
      "CF",
      "CH",
      "CM",
      "CO",
      "CR",
      "CT",
      "CV",
      "CW",
      "DA",
      "DD",
      "DE",
      "DG",
      "DH",
      "DL",
      "DN",
      "DT",
      "DY",
      "E",
      "EC",
      "EH",
      "EN",
      "EX",
      "FK",
      "FY",
      "G",
      "GL",
      "GU",
      "HA",
      "HD",
      "HG",
      "HP",
      "HR",
      "HS",
      "HU",
      "HX",
      "IG",
      "IP",
      "IV",
      "KA",
      "KT",
      "KW",
      "KY",
      "L",
      "LA",
      "LD",
      "LE",
      "LL",
      "LN",
      "LS",
      "LU",
      "M",
      "ME",
      "MK",
      "ML",
      "N",
      "NE",
      "NG",
      "NN",
      "NP",
      "NR",
      "NW",
      "OL",
      "OX",
      "PA",
      "PE",
      "PH",
      "PL",
      "PO",
      "PR",
      "RG",
      "RH",
      "RM",
      "S",
      "SA",
      "SE",
      "SG",
      "SK",
      "SL",
      "SM",
      "SN",
      "SO",
      "SP",
      "SR",
      "SS",
      "ST",
      "SW",
      "SY",
      "TA",
      "TD",
      "TF",
      "TN",
      "TQ",
      "TR",
      "TS",
      "TW",
      "UB",
      "W",
      "WA",
      "WC",
      "WD",
      "WF",
      "WN",
      "WR",
      "WS",
      "WV",
      "YO",
      "ZE",
      "BT",
      "GY",
      "IM",
      "JE"
    ),
    value = rnorm(124)
  )

# Make sure your postal codes are stored in a column called name
# Example:
# dta <- rename(dta, name = name)

# OPTIONAL: Depending on your data, you may need to rescale it for the color ramp to work
dta$value <- rescale(dta$value, newrange = c(0, 1))

library(maptools)
# Download a shapefile of postal codes into your working directory
download.file(
  "http://www.opendoorlogistics.com/wp-content/uploads/Data/UK-postcode-boundaries-Jan-2015.zip",
  "postal_shapefile"
)

# Unzip the shapefile
unzip("postal_shapefile")

# Read the shapefile, maptool function
postal <- readShapeSpatial("./Distribution/Areas")

# Join your data to the shapefile
u <- raster::merge(postal, dta, by = "name")

# Use the gray function to determine the proper black-and-white color for each postal code
plot(u, col = gray(u$value))
