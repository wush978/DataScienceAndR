# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.db_path <- tempfile(fileext = ".db")
.db_path2 <- tempfile(fileext = ".db")
file.copy(.get_path("example.db"), .db_path)
file.copy(.get_path("example.db"), .db_path2)

assign("db_path",
       .db_path,
       envir = globalenv())

assign("db_path2",
      .db_path2,
      envir = globalenv())

.lvr_land <- read.table(file(.get_path("A_LVR_LAND_A.CSV"), encoding = "BIG5"),
  sep = ",", header = TRUE, stringsAsFactors = FALSE)
assign("lvr_land",
       .lvr_land,
       envir = globalenv())

assign(
  "lvr_land.names",
  c("township", "target", "location", "area.of.squared.meters", 
    "urban.land.division", "non.urban.land.division", "non.urban.land.compilation", 
    "trading.year", "trading.number", "transfer.level", "total.floor", 
    "building.type", "main.purpose", "main.materials", "building.completion.year", 
    "transfer.area.squared.meters", "building.pattern.room", "building.pattern.living.dining", 
    "building.pattern.bathroom", "building.pattern.compartment", 
    "is.managed", "total.price", "unit.price.squared.meters", "parking.type", 
    "parking.area.squared.meters", "parking.price", "remarks", "no."
  ),
  envir = globalenv()
  )