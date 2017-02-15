if (packageVersion("swirl") < package_version("100.3.1-8")) {
  stop("Please upgrade the version of swirl via: `install.packages('swirl', repos = 'http://wush978.github.io/R')`")
}

assign(".get_path",
       function(fname) {
         path <- file.path(lesPath, fname)
         normalizePath(path, mustWork = TRUE)
       },
       envir = globalenv())

assign("check_then_install",
       function(pkg_name, pkg_version) {
         if (!suppressWarnings(suppressMessages(require(pkg_name, character.only = TRUE)))) utils::install.packages(pkg_name) else {
           if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name)
         }
       },
       envir = globalenv())

assign("check_then_install_github", 
       function(pkg_name, pkg_version, ...) {
         if (!require(pkg_name, character.only = TRUE)) devtools::install_github(...) else {
         if (packageVersion(pkg_name) < package_version(pkg_version)) devtools::install_github(...)
         }
       })

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

options(
  "SWIRL_TRACKING_SERVER_IP" = "api.datascienceandr.org,api2.datascienceandr.org",
  "SWIRL_COURSE_VERSION" = "v1.0",
  "repos" = c("http://wush978.github.io/R", "CRAN"="http://mran.revolutionanalytics.com/snapshot/2016-04-01")
)
