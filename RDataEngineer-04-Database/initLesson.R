# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.db_path <- tempfile(fileext = ".db")
file.copy(.get_path("example.db"), .db_path)

assign("db_path",
       .db_path,
       envir = globalenv())

.lvr_land <- read.table(file(.get_path("A_LVR_LAND_A.CSV"), encoding = "BIG5"),
  sep = ",", header = TRUE, stringsAsFactors = FALSE)
assign("lvr_land",
       .lvr_land,
       envir = globalenv())
