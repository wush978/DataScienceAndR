# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.get_path <- function(fname) {
  normalizePath(file.path(find.package("swirl", quiet = TRUE), sprintf("Courses/DataScienceAndR/RBasic-07-Loading-Dataset/%s", fname)), mustWork = TRUE)
}

assign("lvr_land.path", 
       .get_path("A_LVR_LAND_A.CSV"), 
       envir = globalenv())


assign("orglist.path", 
       .get_path("orglist-100.CSV"), 
       envir = globalenv())

check_then_install <- function(pkg_name, pkg_version) {
  if (!require(pkg_name, character.only = TRUE)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
    if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
  }
}

