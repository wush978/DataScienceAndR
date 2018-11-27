. <- sprintf("%s.%s", R.version$major, R.version$minor)
. <- file.path("R-lib", .)
dir.create(., recursive = TRUE, showWarnings = FALSE)
.libPaths(new = .)
Sys.setenv(R_LIBS=.)
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
  Sys.setenv("SWIRL_DEV"="TRUE")
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
if (!suppressWarnings(require(subprocess))) install.packages("subprocess", repos = repos)
if (!suppressWarnings(require(magrittr))) install.packages("magrittr", repos = repos)

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

# retry start

if (file.exists(user_data.path <- file.path(system.file("", package = "swirl"), "user_data"))) {
  unlink(user_data.path, recursive = TRUE, force = TRUE)
}
dir.create(file.path(user_data.path, "wush"), recursive = TRUE)

.env <- Sys.getenv()
.env[["R_LIBS"]] <- .libPaths()[1]
.env[["LC_ALL"]] <- "zh_TW.UTF-8"
.env[["LANGUAGE"]] <- "zh_TW"
log.path <- tempfile()
p <- spawn_process(
  R.home("bin/R"),
  c("--no-save", "--no-readline", "--quiet", "--interactive", sprintf("--args %s", log.path)),
  .env,
  workdir = getwd()
)

p.buf <- new.env()
p.buf$output <- list()
p.buf$show <- 0

get_stdout <- function() {
  lapply(p.buf$output, "[[", "stdout") %>%
    unlist()
}

get_stderr <- function() {
  lapply(p.buf$output, "[[", "stderr") %>%
    unlist()
}

get_buf_size <- function() {
  length(p.buf$output)
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

wait_until <- function(checker, is.stdout = TRUE, check.last = TRUE, current.index = get_buf_size()) {
  if (check.last && current.index > 0) {
    if (is.stdout) {
      if (checker(p.buf$output[[current.index]]$stdout)) return(invisible(NULL))
    } else {
      if (checker(p.buf$output[[current.index]]$stderr)) return(invisible(NULL))
    }
  }
  retry <- 0
  colddown <- 0.1
  start.index <- current.index + 1
  while(TRUE) {
    Sys.sleep(colddown)
    read()
    end.index <- get_buf_size()
    for(i in start.index:end.index) {
      if (is.stdout) {
        if (checker(p.buf$output[[i]]$stdout)) return(invisible(NULL))
      } else {
        if (checker(p.buf$output[[i]]$stderr)) return(invisible(NULL))
      }
    }
    start.index <- end.index + 1
    retry <- retry + 1
    if (retry %% 5 == 0) enter_process("\n")
    if (retry > 60) stop(sprintf("wait_until timeout"))
    colddown <- min(colddown + 0.1, 1)
  }
}

search_selection <- function(txt, ans) {
  for(char in c("\\", "(", ")", "^", "[", "]", "{", "}", ".", "$", "*", "+")) {
    ans <- gsub(char, sprintf("\\%s", char), ans, fixed = TRUE)
  }
  . <- regexec(sprintf("^\\s*(\\d+): %s$", ans), txt) %>%
    regmatches(x = txt) %>%
    Filter(f = function(.) length(.) == 2)
  stopifnot(length(.) == 1)
  .[[1]][2]
}

enter_process <- function(cmd, breakline = TRUE) {
  if (breakline) {
    if (substring(cmd, nchar(cmd), nchar(cmd)) != "\n") {
      cmd <- sprintf("%s\n", cmd)
    }
  }
  process_write(p, cmd)
  cat(sprintf("(process_write)> %s\n", cmd))
  Sys.sleep(0.1)
  read()
  show()
  invisible(NULL)
}

get_character <- function(expr.txt) {
  cmd <- sprintf("cat(sprintf('output:%%s:\\n', %s))", expr.txt)
  enter_process(cmd, breakline = TRUE)
  wait_until(function(.) any(grepl("output:", ., fixed = TRUE)))
  . <- lapply(p.buf$output, "[[", "stdout") %>%
    grep(pattern = "output:", fixed = TRUE) %>%
    max()
  . <- p.buf$output[[.]]$stdout
  m <- regexec("output:(.*):$", .)
  regmatches(., m) %>%
    Filter(f = function(.) length(.) == 2) %>%
    extract2(1) %>%
    extract(2)
}

enter_swirl <- function() {
  enter_process(sprintf("options(repos=c(CRAN='%s'))\n", repos))
  enter_process("options(editor = function(...){}, browser = function(...){})\n")
  enter_process(". <- as.environment('package:utils')")
  enter_process("unlockBinding('View', .)")
  enter_process("assign('View', function(x, title) NULL, envir = .)")
  enter_process("lockBinding('View', .)")
  enter_process("Sys.setlocale(locale = 'zh_TW.UTF-8')\n")
  enter_process(". <- tempfile()")
  enter_process("dir.create(.)")
  enter_process(".libPaths(new = c(., .libPaths()))")
  enter_process("library(swirl)\n")
  enter_process("delete_progress('wush')\n")
  create.cb.script <- '
.swirl.slave.cb <- addTaskCallback(function(expr, value, ok, visible) {
  tryCatch({
    .e <- swirl:::.get_e()
    . <- rownames(.e$current.row)
    i <- as.integer(.) + 1
    course <- basename(.e$path)
    txt <- sprintf("\n%s::%d\n", course, i)
    write(txt, commandArgs(TRUE))
  }, error = function(e) {
    warning(conditionMessage(e))
  })
  TRUE
})
'
  enter_process(create.cb.script)
  enter_process("swirl()\n")
  enter_process("3\n")
  enter_process("wush\n")
  enter_process("333\n")
  enter_process("\n")
}

enter_course <- function(name) {
  wait_until(function(.) any(grepl("帶我去 swirl 課程庫！", ., fixed = TRUE)), check.last = TRUE)
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
  wait_until(function(.) any(grepl("Your status has beed updated to tracking server", ., fixed = TRUE)), is.stdout = FALSE, check.last = TRUE)
  for(i in 2:length(src)) {
    if (src[[i]]$Class == "text") {
      enter_process("\n")
    } else if (src[[i]]$Class == "cmd_question") {
      wait_until(function(.) any(grepl("> ", ., fixed = TRUE)), check.last = TRUE)
      enter_process(src[[i]]$CorrectAnswer, TRUE)
    } else if (src[[i]]$Class == "script") {
      wait_until(function(.) any(grepl("> ", ., fixed = TRUE)), check.last = TRUE)
      script_temp_path <- get_character("swirl:::.get_e()$script_temp_path")
      correct_script_temp_path <- get_character("swirl:::.get_e()$correct_script_temp_path")
      file.copy(from = correct_script_temp_path, to = script_temp_path, overwrite = TRUE)
#      enter_process("cat(sprintf('output:%s:', swirl:::.get_e()$script_temp_path))\n")
      enter_process("submit()\n")
    } else if (src[[i]]$Class == "mult_question") {
      wait_until(function(.) any(grepl("Selection:", ., fixed = TRUE)), check.last = TRUE)
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
