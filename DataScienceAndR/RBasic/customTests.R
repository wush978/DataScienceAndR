test_package_version <- function(pkg_name, pkg_version) {
  e <- get("e", parent.frame())
  tryCatch(
    packageVersion(pkg_name) >= package_version(pkg_version),
    error = function(e) FALSE)
}