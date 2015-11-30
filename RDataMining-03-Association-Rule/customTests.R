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
  e <- new.env()
  e$subset <- arules::subset
  e$`%in%` <- arules::`%in%`
  if (info$MBCS & !info$`UTF-8`) {
    try(source(path, local = e), silent = TRUE)
  } else {
    try(source(path, local = e, encoding = "UTF-8"), silent = TRUE)
  }
}

rdatamining_03_test <- function() {
  e <- get("e", parent.frame())
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("rules2", "rules2.fulltime")
  rules2.ref <- apriori(Adult, parameter = list(support = 0.3, confidence = 0.9))
  `%in%` <- arules::`%in%`
  rules2.fulltime.ref <- arules::subset(rules2.ref, subset = lhs %in% "hours-per-week=Full-time")
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