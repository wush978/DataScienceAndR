.get_path <- function(fname) {
  path <- file.path(lesPath, fname)
  normalizePath(path, mustWork = TRUE)
}

.read.table.big5 <- function(file, header = FALSE, sep = "", ...) {
  info <- l10n_info()
  if (info$MBCS & (!info$`UTF-8`)) {
    read.table(file, header = header, sep = sep, ...) 
  } else {
    read.table(file(file, encoding = "BIG5"), header = header, sep = sep, ...) 
  }
}
