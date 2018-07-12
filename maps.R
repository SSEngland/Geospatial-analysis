library(ggmap)
library(mapproj)
map <- get_map(location = 'Europe', zoom = 4)
ggmap(map)

library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap)

plot(newmap,
  xlim = c(-20, 59),
  ylim = c(35, 71),
  asp = 1
)

library(ggmap)
europe.limits <- geocode(c("CapeFligely,RudolfIsland,Franz Josef Land,Russia",
  "Gavdos,Greece",
  "Faja Grande,Azores",
  "SevernyIsland,Novaya Zemlya,Russia")
)
europe.limits

plot(newmap,
  xlim = range(europe.limits$lon),
  ylim = range(europe.limits$lat),
  asp = 1
)