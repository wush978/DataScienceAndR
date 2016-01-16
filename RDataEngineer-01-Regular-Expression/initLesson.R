# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.get_path <- function(fname) {
  path <- file.path(swirl::get_swirl_option("courses_dir"),
            "DataScienceAndR", "RDataEngineer-01-Regular-Expression",
            fname)
  normalizePath(path, mustWork = TRUE)
}

assign("hospital_path", 
       .get_path("DataGov26199.csv"),
       envir = globalenv())
