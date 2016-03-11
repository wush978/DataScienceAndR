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

assign("translater_path", c(
  "6to7" = .get_path("6to7.txt"),
  "7to8" = .get_path("7to8.txt"),
  "8to9" = .get_path("8to9.txt")),
  envir = globalenv())

assign("gdp_df_path",
       .get_path("gdp_df_tutorial.R"),
       envir = globalenv())

