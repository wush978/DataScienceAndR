# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rbasic_07_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("answer")
  answer.bin <- readBin(orglist.path, what = "raw", n = file.info(orglist.path)$size)
  get_text_connection_by_l10n_info <- function(x) {
    info <- l10n_info()
    if (info$MBCS & !info$`UTF-8`) {
      textConnection(x)
    } else {
      textConnection(x, encoding = "UTF-8")
    }
  }
  answer.txt <- stringi::stri_encode(answer.bin, "UTF-16", to = "UTF-8")
  answer.ref <- read.table(get_text_connection_by_l10n_info(answer.txt), header = TRUE, sep = ",")
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

test_package_version <- function(pkg_name, pkg_version) {
  e <- get("e", parent.frame())
  tryCatch(
    packageVersion(pkg_name) >= package_version(pkg_version),
    error = function(e) FALSE)
}

test_search_path <- function(pkg_name) {
  tryCatch(
    length(grep(sprintf("/%s$", pkg_name), searchpaths())) > 0,
    error = function(e) FALSE)
}

test_lvr_land_txt <- function() {
  e <- get("e", parent.frame())
  reference <- read.table(get_text_connection_by_l10n_info(lvr_land.txt), header = TRUE, sep = ",")
  is.data.frame(reference) & nrow(reference) == 19 & omnitest(correctVal = reference)
}
