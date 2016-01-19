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
  convert <- function(x, encoding) {
    Encoding(x) <- encoding
    enc2native(x)
  }
  converter <- function(x, encoding) {
    if (is.character(x)) convert(x, encoding) else x
  }
  .tmp1 <- dbReadTable(db, "lvr_land2")
  .tmp2 <- readRDS(.get_path("lvr_land_read.Rds"))
  .tmp1.1 <- lapply(.tmp1, converter, "BIG5")
  .tmp2.1 <- lapply(.tmp2, converter, "UTF-8")
  names(.tmp1.1) <- names(.tmp2.1) <- NULL
  isTRUE(all.equal(.tmp1.1, .tmp2.1))
}
