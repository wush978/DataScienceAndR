# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

check_then_install <- function(pkg_name, pkg_version) {
  if (!require(pkg_name, character.only = TRUE)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
    if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
  }
}

