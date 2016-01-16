.get_path <- function(fname) {
  path <- file.path(lesPath, fname)
  normalizePath(path, mustWork = TRUE)
}


