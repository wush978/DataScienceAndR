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
  swirl::install_course_directory("~/DataScienceAndR")
})
R.date <- local({
  m <- regexec("\\((.*)\\)$", R.version.string)
  . <- regmatches(R.version.string, m)
  . <- Filter(., f = function(.) length(.) == 2)
  .[[1]][2]
})
R.date <- as.Date(R.date)
repos <- c(CRAN = sprintf("https://cran.microsoft.com/snapshot/%s", R.date + 7))
install.packages("subprocess", repos = repos)
install.packages("magrittr", repos = repos)

library(magrittr)
library(subprocess)

R.date <- local({
  m <- regexec("\\((.*)\\)$", R.version.string)
  regmatches(R.version.string, m) %>%
    Filter(f = function(.) length(.) == 2) %>%
    extract2(1) %>%
    extract(2)
}) %>%
  as.Date()
repos <- c(CRAN = sprintf("https://cran.microsoft.com/snapshot/%s", R.date + 7))

if (file.exists(user_data.path <- file.path(system.file("", package = "swirl"), "user_data"))) {
  unlink(user_data.path, recursive = TRUE, force = TRUE)
}
dir.create(file.path(user_data.path, "wush"), recursive = TRUE)

p <- spawn_process(
  R.home("bin/R"),
  c("--no-save", "--no-readline", "--quiet", "--interactive"),
  c(R_LIBS = .libPaths()[1], LC_ALL = "zh_TW.UTF-8", LANGUAGE="zh_TW"),
  workdir = getwd()
)

p.buf <- new.env()
p.buf$output <- list()
p.buf$show <- 0

get_stderr <- function() {
  lapply(p.buf$output, "[[", "stdout") %>%
    unlist()
}

search_output <- function(checker, is.output = TRUE) {
  lapply(p.buf$output, "[[", ifelse(is.output, "stdout", "stderr")) %>%
    sapply(checker) %>%
    which()
}

get_stderr <- function() {
  lapply(p.buf$output, "[[", "stderr") %>%
    unlist()
}

show <- function() {
  if (p.buf$show < length(p.buf$output)) {
    p.buf$show <- p.buf$show + 1
    cat(sprintf("(%d)---stdout---\n", p.buf$show))
    cat(p.buf$output[[p.buf$show]]$stdout, sep = "\n")
    cat(sprintf("(%d)---stderr---\n", p.buf$show))
    cat(p.buf$output[[p.buf$show]]$stderr, sep = "\n")
  }
}

read <- function() {
  p.buf$output[[length(p.buf$output) + 1]] <- process_read(p)
  show()
}

wait_until <- function(checker, is.stdout = TRUE, check.last = TRUE) {
  if (check.last && length(p.buf$output) > 0) {
    if (is.stdout) {
      if (checker(p.buf$output[[length(p.buf$output)]]$stdout)) return(invisible(NULL))
    } else {
      if (checker(p.buf$output[[length(p.buf$output)]]$stderr)) return(invisible(NULL))
    }
  }
  while(TRUE) {
    Sys.sleep(1)
    read()
    if (is.stdout) {
      if (checker(p.buf$output[[length(p.buf$output)]]$stdout)) return(invisible(NULL))
    } else {
      if (checker(p.buf$output[[length(p.buf$output)]]$stderr)) return(invisible(NULL))
    }
  }
}

search_selection <- function(txt, ans) {
  . <- regexec(sprintf("(\\d+): %s", ans), txt) %>%
    regmatches(x = txt) %>%
    Filter(f = function(.) length(.) == 2)
  stopifnot(length(.) == 1)
  .[[1]][2]
}

enter_process <- function(cmd, breakline = FALSE) {
  if (breakline) cmd <- sprintf("%s\n", cmd)
  process_write(p, cmd)
  cat(sprintf("(process_write)> %s\n", cmd))
  Sys.sleep(0.5)
  read()
  Sys.sleep(0.5)
  show()
  invisible(NULL)
}

get_character <- function(expr.txt) {
  cmd <- sprintf("cat(sprintf('output:%%s:\n', %s))", expr.txt)
  enter_process(cmd)
  enter_process("\n")
  wait_until(function(.) any(grepl("output:", ., fixed = TRUE)))
  . <- lapply(p.buf$output, "[[", "stdout") %>%
    grep(pattern = "output:", fixed = TRUE) %>%
    max()
  . <- p.buf$output[[.]]$stdout
  m <- regexec("^output:(.*):$", .)
  regmatches(., m) %>%
    Filter(f = function(.) length(.) == 2) %>%
    extract2(1) %>%
    extract(2)
}

enter_swirl <- function() {
  enter_process(sprintf("options(repos=c(CRAN='%s'))\n", repos))
  enter_process("options(editor = 'less', browser = 'less')\n")
  enter_process("Sys.setlocale(locale = 'zh_TW.UTF-8')\n")
  enter_process("library(swirl)\n")
  enter_process("y\n")
  enter_process("y\n")
  enter_process("delete_progress('wush')\n")
  enter_process("swirl()\n")
  enter_process("3\n")
  enter_process("wush\n")
  enter_process("333\n")
  enter_process("\n")
}

enter_course <- function(name) {
  read()
  . <- search_output(function(.) any(grepl("帶我去 swirl 課程庫！", ., fixed = TRUE))) %>%
    max()
  search_selection(p.buf$output[[.]]$stdout, "DataScienceAndR") %>%
    enter_process(breakline = TRUE)
  . <- search_output(function(.) any(grepl(name, ., fixed = TRUE))) %>%
    max()
  search_selection(p.buf$output[[.]]$stdout, name) %>%
    enter_process(breakline = TRUE)
  src <- system.file(file.path("Courses/DataScienceAndR", name, "lesson.yaml"), package = "swirl") %>%
    yaml::yaml.load_file()
  Sys.sleep(10)
  for(i in 2:length(src)) {
    if (src[[i]]$Class == "text") {
      enter_process("\n")
    } else if (src[[i]]$Class == "cmd_question") {
      enter_process("skip()\n")
    } else if (src[[i]]$Class == "script") {
      script_temp_path <- get_character("swirl:::.get_e()$script_temp_path")
      correct_script_temp_path <- get_character("swirl:::.get_e()$correct_script_temp_path")
      file.copy(from = correct_script_temp_path, to = script_temp_path, overwrite = TRUE)
#      enter_process("cat(sprintf('output:%s:', swirl:::.get_e()$script_temp_path))\n")
      enter_process("submit()\n")
    } else if (src[[i]]$Class == "mult_question") {
      ans <- src[[i]]$CorrectAnswer %>% as.character()
      . <- search_output(function(.) any(grepl("Selection:", ., fixed = TRUE))) %>%
        max()
      . <- search_selection(p.buf$output[[.]]$stdout, ans)
      enter_process(., breakline = TRUE)
    } else {
      browser()
      stop()
    }
  }
}

# Execusion
wait_until(function(.) any(grepl("> ", ., fixed = TRUE)))
enter_swirl()
lapply(
  system.file("Courses/DataScienceAndR", package = "swirl") %>% dir(),
  enter_course
)
process_terminate(p)
rm(p.buf)
gc()
