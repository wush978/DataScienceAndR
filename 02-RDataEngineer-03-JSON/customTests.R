# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.
rdataengineer_03_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("sna1", "lat1", "lng1", "tot1", "sbi1",
                 "sna2", "lat2", "lng2", "tot2", "sbi2",
                 "youbike2", "answer")
  youbike1 <- fromJSON(youbike_path)

  sna2.ref <- sna1.ref <- youbike1$result$results$sna
  lat2.ref <- lat1.ref <- youbike1$result$results$lat
  lng2.ref <- lng1.ref <- youbike1$result$results$lng
  tot2.ref <- tot1.ref <- youbike1$result$results$tot
  sbi2.ref <- sbi1.ref <- youbike1$result$results$sbi
  youbike2.ref <- fromJSON(youbike_path, simplifyDataFrame = FALSE)
  answer.ref <- data.frame(stringsAsFactors = FALSE,
    sna = sna2.ref,
    lat = as.numeric(lat2.ref),
    lng = as.numeric(lng2.ref),
    tot = as.integer(tot2.ref),
    sbi = as.integer(sbi2.ref)
  )

  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}
