src <- readLines(file(pirate_path, encoding = "BIG5"))
tmp <- strsplit(src, readLines(.get_path(".hw"))[2])
key <- sapply(tmp, "[[", 1)
is_target <- key == readLines(.get_path(".hw"))[1]
value <- sapply(tmp[is_target], "[[", 2)
pirate <- data.frame(
  lat = substring(value, 3, 4) %>% as.numeric + substring(value, 6, 7) %>% as.numeric / 60,
  lng = substring(value, 12, 14) %>% as.numeric + substring(value, 16, 17) %>% as.numeric / 60)
library(leaflet)
leaflet(pirate) %>%
  addMarkers(lng = ~lng, lat = ~lat) %>%
  addTiles()
  