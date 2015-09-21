check_then_install <- function(pkg_name, pkg_version) {
  if (!require(pkg_name)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
  if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
  }
}

check_then_install_github <- function(pkg_name, pkg_version, ...) {
  if (!require(pkg_name)) devtools::install_github(...) else {
  if (packageVersion(pkg_name) < package_version(pkg_version)) devtools::install_github(...)
  }
}