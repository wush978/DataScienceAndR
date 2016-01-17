.get_path <- function(fname) {
  path <- file.path(lesPath, fname)
  normalizePath(path, mustWork = TRUE)
}

.read.table.big5 <- function(file, header = FALSE, sep = "", ...) {
  info <- l10n_info()
  if ("codepage" %in% names(info)) {
    read.table(file, header = header, sep = sep, ...) 
  } else {
    read.table(file(file, encoding = "BIG5"), header = header, sep = sep, ...) 
  }
}

check_then_install <- function(pkg_name, pkg_version) {
  if (!require(pkg_name, character.only = TRUE)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
    if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
  }
}

