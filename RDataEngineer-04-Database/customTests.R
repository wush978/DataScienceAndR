# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

check_lvr_land <- function(db) {
  .tmp1 <- dbReadTable(db, "lvr_land")
  .tmp2 <- readRDS(.get_path("lvr_land_read.Rds"))
  .tmp1.1 <- lapply(.tmp1, function(x) x)
  .tmp2.1 <- lapply(.tmp2, function(x) {
    if (is.character(x)) {
      Encoding(x) <- "UTF-8"
      enc2native(x)
    } else x
    })
  isTRUE(all.equal(.tmp1.1, .tmp2.1))
}
