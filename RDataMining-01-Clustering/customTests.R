# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

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

source_by_l10n_info <- function(path) {
  info <- l10n_info()
  if (info$MBCS & !info$`UTF-8`) {
    try(source(path, local = new.env()), silent = TRUE)
  } else {
    try(source(path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  }
}
rdatamining_01_test <- function() {
  e <- get("e", parent.frame())
  check_then_install("mlbench", "2.1.1")
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("cl1", "cl2", "cl3")
  reference <- as.integer(get("shapes", envir = globalenv())$classes)
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        reference
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}
