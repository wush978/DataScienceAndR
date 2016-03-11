# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("power_path", 
       .get_path("power.txt"), 
       envir = globalenv())

assign("gdp_path", 
       .get_path("NA8103A1Ac.csv"), 
       envir = globalenv())

assign("translation", 
       read.csv(.get_path("translation.csv"), header = TRUE, stringsAsFactors = FALSE),
       envir = globalenv())

assign("gdp_df_path",
       .get_path("gdp_df_tutorial.R"),
       envir = globalenv())

