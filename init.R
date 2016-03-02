suppressWarnings({
  print(R.Version()$version.string)
  repos <- "http://wush978.github.io/R"
  options(install.packages.check.source = "no", "install.packages.compile.from.source" = "no")
  pkgs.info <- available.packages(contriburl = contrib.url(repos))
  print(pkgs.info)
  invisible(lapply("", function(pkg) {
    if (!require(pkg, character.only = TRUE)) {
      utils::install.packages(pkg, repos = repos)
    }
  }))
  pkgs.installed <- installed.packages()
  pkgs.to_check <- intersect(
    rownames(pkgs.installed),
    rownames(pkgs.info))
  for(pkg in pkgs.to_check) {
    x1 <- package_version(pkgs.info[pkg,"Version"])
    x2 <- packageVersion(pkg)
    if (x1 > x2) utils::install.packages(pkg, repos = repos)
  }
  if (require(swirl)) {
    x1 <- package_version(pkgs.info["swirl", "Version"])
    x2 <- packageVersion("swirl")
    if (x1 > x2) install_swirl <- TRUE else install_swirl <- FALSE
  } else {
    install_swirl <- TRUE
  }
  if (install_swirl) utils::install.packages("swirl", repos = repos, type = "source")
  library(swirl)
  library(curl)
  try(uninstall_course("DataScienceAndR"), silent=TRUE)
  install_course_github("wush978", "DataScienceAndR", "course")
})
