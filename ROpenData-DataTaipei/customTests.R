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

