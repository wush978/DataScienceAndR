# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

check_lvr_land <- function(db) {
  .db <- RSQLite::dbConnect(RSQLite::SQLite())
  tryCatch({
    your_answer <- RSQLite::dbReadTable(db, "lvr_land2")
    RSQLite::dbWriteTable(.db, "lvr_land", readRDS(.get_path(.vr_land_read.Rds)))
    referenced_answer <- RSQLite::dbReadTable(.db, "lvr_land")
    if (isTRUE(all.equal(your_answer, .tmp2.1))) return(TRUE) else {
      . <- capture.output(all.equal(your_answer, referenced_answer))
      cat(., sep = "\n", file = stderr());cat("\n", file = stderr())
      return(FALSE)
    }
  }, error = function(e) {
    . <- conditionMessage(e)
    cat(., sep = "\n", file = stderr());cat("\n", file = stderr())
    return(FALSE)
  }, finally = {
    RSQLite::dbDisconnect(.db)    
  })
}

rdataengineer_04_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("tb_list", "twii_head", "twii_tail")
  tryCatch({
    tb_list <- get("tb_list", envir = globalenv())
    twii_head <- get("twii_head", envir = globalenv())
    twii_tail <- get("twii_tail", envir = globalenv())
    .db <- dbConnect(drv, get("db_path2", globalenv()))
    if (!isTRUE(all.equal(sort(tb_list), sort(c("CO2", "TWII", "iris"))))) {
      if (!isTRUE(all.equal(sort(tb_list), sort(dbListTables(.db))))) {
        stop("tb_list is wrong! try again.\n")
      }
    }
    if (!isTRUE(all.equal(twii_head, "2007-01-02"))) {
      stop("twii_head is wrong! try again.\n")
    }
    if (!isTRUE(all.equal(twii_tail, "2016-01-18"))) {
      stop("twii_tail is wrong! try again.\n")
    }
    if (!"setosa" %in% dbListTables(.db)) {
      stop("Table setosa is gone! Do you remember to run dbCommit?")
    }
    setosa <- dbReadTable(.db, "setosa")
    setosa.ref <- readRDS(.get_path("setosa.Rds"))
    if (!isTRUE(all.equal(setosa, setosa.ref))) {
      stop("The content of the table setosa is incorrect!")
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
  
}
