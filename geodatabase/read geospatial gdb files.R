library(rgdal)

# The input file geodatabase
fgdb <- "G:/Customer & Marketing/Customer Analytics/04. Data Innovation/03. Data Lake/Data Source Exploration/Flood/FGDB_Full.gdb"

# List all feature classes in a file geodatabase
subset(ogrDrivers(), grepl("GDB", name))
fc_list <- ogrListLayers(fgdb)

#[1] "Cluster_Maps"                                                  
#[2] "Communities_at_Risk_by_LLFA"                                   
#[3] "Surface_Water_Flood_Risk_Exposure_Grid_People_Sensitivity_Grid"
#[4] "People_Sensitivity_Map_by_LLFA"                                
#[5] "Blue_Square_Grid"

#Surface Water Flood Risk Exposure Grid - 1km square grid that shows places above the flood risk threshold defined,
#using the 1 in 100 and 1000 annual probability (deep) Flood Map for Surface Water. 

#Flood risk thresholds used to generate the "blue Squares": - Number of people > 200 - Number of critical services, 
#including electricity and water > 1 - Number of non-residential properties > 20 

#Cluster Maps - are aggregations of 3km by 3km squares that each contain at least 5 touching "blue squares" 
#(i.e. 1km grid squares where one of the thresholds above is exceeded) 

#Communities at Risk by Lead Local Flooding Authority 

#People Sensitivity Map by Lead Local Flood Authority 


# Read the feature class, change the layer every time to a different one...
fc <- readOGR(dsn=fgdb,layer="Blue_Square_Grid")

# Determine the FC extent, projection, and attribute information
summary(fc)

# View the feature class
plot(fc)

# The input file geodatabase
shp <- "G:/Customer & Marketing/Customer Analytics/04. Data Innovation/03. Data Lake/Data Source Exploration/Flood/SHP_Full.gdb"

# List all feature classes in a file geodatabase
subset(ogrDrivers(), grepl("GDB", name))
fc_list <- ogrListLayers(shp)

#[1] "Blue_Square_Grid"                                              
#[2] "Cluster_Maps"                                                  
#[3] "Communities_at_Risk_by_LLFA"                                   
#[4] "People_Sensitivity_Map_by_LLFA"                                
#[5] "Surface_Water_Flood_Risk_Exposure_Grid_People_Sensitivity_Grid"


# Read the feature class, change the layer every time to a different one...
fc <- readOGR(dsn=shp,layer="Blue_Square_Grid")

# Determine the FC extent, projection, and attribute information
summary(fc)

# View the feature class
plot(fc)