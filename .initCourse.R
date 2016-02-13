assign(".get_path",
       function(fname) {
         path <- file.path(lesPath, fname)
         normalizePath(path, mustWork = TRUE)
       },
       envir = globalenv())

assign("check_then_install",
       function(pkg_name, pkg_version) {
         if (!require(pkg_name, character.only = TRUE)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
           if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
         }
       },
       envir = globalenv())

assign("test_package_version",
       function(pkg_name, pkg_version) {
         e <- get("e", parent.frame())
         tryCatch(
           packageVersion(pkg_name) >= package_version(pkg_version),
           error = function(e) FALSE)
       },
       envir = globalenv())

assign("test_search_path",
       function(pkg_name) {
         tryCatch(
           length(grep(sprintf("/%s$", pkg_name), searchpaths())) > 0,
           error = function(e) FALSE)
       },
       envir = globalenv())

assign(".read.table.big5",
       function(file, header = FALSE, sep = "", ...) {
         info <- l10n_info()
         if ("codepage" %in% names(info)) {
           read.table(file, header = header, sep = sep, ...)
         } else {
           read.table(file(file, encoding = "BIG5"), header = header, sep = sep, ...)
         }
       },
       envir = globalenv())

if (!interactive()) {
  assign("View", function(x) invisible(x), envir = globalenv())
  assign("browseURL", function(x) invisible(x), envir = globalenv())
}

assign("issue", function() browseURL("https://github.com/wush978/DataScienceAndR/issues"), envir = globalenv())
assign("chat", function() browseURL("https://gitter.im/wush978/DataScienceAndR"), envir = globalenv())

assign("source_by_l10n_info", function(path) {
  info <- l10n_info()
  if (info$MBCS & !info$`UTF-8`) {
    try(source(path, local = new.env()), silent = TRUE)
  } else {
    try(source(path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  }
}, envir = globalenv())

assign("check_val", function(name, value) {
  e <- get("e", parent.frame())
  tryCatch({
    result <- all.equal(get(name, e), value)
    if (!isTRUE(result)) {
      message(result)
      FALSE
    } else TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
})

options(
  "SWIRL_TRACKING_SERVER_IP" = "api.datascienceandr.org",
  "SWIRL_COURSE_VERSION" = "e0334fff35e5d8342ec58f8c73de07d9d43cb026"
)
