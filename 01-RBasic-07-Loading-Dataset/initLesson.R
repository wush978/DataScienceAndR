# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("lvr_land.path", 
       .get_path("A_LVR_LAND_A.CSV"), 
       envir = globalenv())


assign("orglist.path", 
       .get_path("orglist-100.CSV"), 
       envir = globalenv())

get_text_connection_by_l10n_info <- function(x) {
  info <- l10n_info()
  if (info$MBCS & !info$`UTF-8`) {
    textConnection(x)
  } else {
    textConnection(x, encoding = "UTF-8")
  }
}

