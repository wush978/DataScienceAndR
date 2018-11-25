. <- sprintf("%s.%s", R.version$major, R.version$minor)
. <- file.path("R-lib", .)
dir.create(., recursive = TRUE, showWarnings = FALSE)
.libPaths(new = .)
Sys.setenv(R_LIBS=.)
install.packages("remotes")
if (package_version(R.version) < package_version("3.2.3")) local({
  msg <- sprintf("The version of R (%s) is not compatible with the course content. Please visit https://mran.revolutionanalytics.com/snapshot/2017-04-01/ to upgrade your R.", package_version(R.version))
  Encoding(msg) <- "UTF-8"
  stop(msg)
})


local({
  repos <- "https://wush978.github.io/R"
  if (!suppressWarnings(require(remotes))) install.packages("remotes", repos = "http://cran.csie.ntu.edu.tw")
  if (!suppressWarnings(require(pvm))) utils::install.packages("pvm", repos = "https://wush978.github.io/R", type = "source")
  pvm::import.packages(sprintf("https://raw.githubusercontent.com/wush978/pvm-list/master/dsr-%s.yml", package_version(R.version)))
  utils::install.packages("swirl", repos = repos)
  library(swirl)
  library(curl)
  library(methods)
  try(uninstall_course("DataScienceAndR"), silent=TRUE)
})
R.date <- local({
  m <- regexec("\\((.*)\\)$", R.version.string)
  regmatches(R.version.string, m) %>%
    Filter(f = function(.) length(.) == 2) %>%
    extract2(1) %>%
    extract(2)
}) %>%
  as.Date()
repos <- c(CRAN = sprintf("https://cran.microsoft.com/snapshot/%s", R.date + 7))
install.packages("subprocess", repos = repos)
install.packages("magrittr", repos = repos)
