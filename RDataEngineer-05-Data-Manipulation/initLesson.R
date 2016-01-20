# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("cl_info",
       read.table(file=file(.get_path("cl_info_other.csv"), encoding = "UTF-8"),
         sep=",",stringsAsFactors=FALSE,header=TRUE),
       envir = globalenv())
