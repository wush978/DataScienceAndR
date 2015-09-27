# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

check_then_install <- function(pkg_name, pkg_version) {
  if (!require(pkg_name, character.only = TRUE)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
  if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
  }
}

check_then_install_github <- function(pkg_name, pkg_version, ...) {
  if (!require(pkg_name, character.only = TRUE)) devtools::install_github(...) else {
  if (packageVersion(pkg_name) < package_version(pkg_version)) devtools::install_github(...)
  }
}

.get_path <- function(fname) {
  file.path(find.package("swirl", quiet = TRUE), sprintf("Courses/DataScienceAndR/RExample-Power-GDP/%s", fname))
}

assign("power_path", 
       .get_path("power.txt"), 
       envir = globalenv())

assign("gdp_path", 
       .get_path("NA8103A1Ac.csv"), 
       envir = globalenv())

assign("translater_path", c(
  "6to7" = .get_path("6to7.txt"),
  "7to8" = .get_path("7to8.txt"),
  "8to9" = .get_path("8to9.txt")),
  envir = globalenv())



