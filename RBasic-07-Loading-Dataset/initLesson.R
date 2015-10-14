# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.get_path <- function(fname) {
  normalizePath(file.path(find.package("swirl", quiet = TRUE), sprintf("Courses/DataScienceAndR/RBasic-07-Loading-Dataset/%s", fname)), mustWork = TRUE)
}

assign("lvr_land.path", 
       .get_path("A_LVR_LAND_A.CSV"), 
       envir = globalenv())


assign("orglist.path", 
       .get_path("orglist-100.CSV"), 
       envir = globalenv())