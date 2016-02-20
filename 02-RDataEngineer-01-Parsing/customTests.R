# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rdataengineer_01_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("pirate_info", "pirate_info_key_value", "pirate_info_key", "pirate_is_coordinate", 
                 "pirate_coordinate_raw", "pirate_coordinate_latitude", "pirate_df")
  pirate_info.ref <- readLines(file(pirate_path, encoding = "BIG5"))
  .delim <- strsplit(pirate_info.ref[2], "")[[1]][3]
  pirate_info_key_value.ref <- strsplit(pirate_info.ref, .delim)
  pirate_info_key.ref <- sapply(pirate_info_key_value.ref, "[", 1)
  pirate_is_coordinate.ref <- pirate_info_key.ref == pirate_info_key.ref[8]
  pirate_coordinate_raw.ref <- local({
    .tmp <- sapply(pirate_info_key_value.ref, "[", 2)
    .tmp[pirate_is_coordinate.ref]
  })
  pirate_coordinate_latitude.ref <- {
    as.integer(substring(pirate_coordinate_raw.ref, 3, 4))
  }
  pirate_coordinate_longitude.ref <- {
    # 請在這邊填寫你的程式碼
    # 這個程式碼可以多行
    as.integer(substring(pirate_coordinate_raw.ref, 12, 14))
  }
  pirate_df.ref <- data.frame(
    latitude = pirate_coordinate_latitude.ref,
    longitude = pirate_coordinate_longitude.ref
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