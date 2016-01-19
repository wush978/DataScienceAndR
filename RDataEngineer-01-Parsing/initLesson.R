# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("hospital_path", 
       .get_path("DataGov25511.csv"),
       envir = globalenv())

assign("pirate_path", 
       .get_path("pirate-info-2015-09.txt"),
       envir = globalenv())
 