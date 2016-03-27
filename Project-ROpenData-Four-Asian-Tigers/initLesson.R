# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.


assign("RawData_KR",.get_path("./aha/Korea/data.csv"),envir = gobalenv())
assign("RawData_USA",.get_path("./aha/USA/data.csv"),envir = gobalenv())
assign("RawData_Taiwan",.get_path("./aha/Taiwan.csv"),envir = gobalenv())
assign("RawData_HK",.get_path("./aha/HK/data.csv"),envir = gobalenv())
assign("RawData_Sigapore",.get_path("./aha/Singapore/data.csv"),envir = gobalenv())
assign("RawData_Japan",.get_path("./aha/Japan/data.csv"),envir = gobalenv())
assign("RawData_China",.get_path("./aha/China/data.csv"),envir = gobalenv())


assign("_path",
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

assign(".delim", ";?\t", envir = globalenv())
