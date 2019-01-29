R.version <- sprintf("%s.%s", R.version$major, R.version$minor)
COURSE_PREFIX <- Sys.getenv("COURSE_PREFIX")
R_LIBS <- c(tempfile(), file.path("R-lib", R.version))
lapply(R_LIBS, dir.create, recursive = TRUE, showWarnings = FALSE)
.libPaths(new = R_LIBS)
Sys.setenv(R_LIBS=paste(R_LIBS, collapse = ":"))

local({
  repos <- "https://wush978.github.io/R"
  if (!suppressWarnings(require(remotes))) install.packages("remotes", repos = "http://cran.csie.ntu.edu.tw", lib = R_LIBS[1])
  if ("pvm" %in% rownames(installed.packages(lib.loc = R_LIBS[1]))) {
    . <- packageVersion("pvm", lib.loc = R_LIBS[1])
    if (. < package_version("0.4.2.2")) {
      utils::install.packages("pvm", repos = "https://wush978.github.io/R", type = "source", lib = R_LIBS[1])
    }
  } else utils::install.packages("pvm", repos = "https://wush978.github.io/R", type = "source", lib = R_LIBS[1])
  stopifnot(packageVersion("pvm", lib.loc = R_LIBS[1]) >= package_version("0.4.2.2"))
  loadNamespace("pvm", lib.loc = R_LIBS[1])
  pvm::import.packages(sprintf("https://raw.githubusercontent.com/wush978/pvm-list/master/dsr-%s.yml", package_version(R.version)), lib = R_LIBS[2])
  utils::install.packages("swirl", repos = repos, lib = R_LIBS[1])
  Sys.setenv("SWIRL_DEV"="TRUE")
  library(swirl)
  library(curl)
  library(methods)
  try(uninstall_course("DataScienceAndR"), silent=TRUE)
  swirl::install_course_directory("~/DataScienceAndR")
})

R.date <- pvm::R.release.dates[R.version]
R_USER_LIBS <- file.path("R-lib", sprintf("%s-%s", R.version, COURSE_PREFIX), R.date)
dir.create(R_USER_LIBS, showWarnings = FALSE)
repos <- c(CRAN = sprintf("https://cran.microsoft.com/snapshot/%s", R.date + 7))
if (!suppressWarnings(require(subprocess))) install.packages("subprocess", repos = repos, lib = R_LIBS[2])
if (!suppressWarnings(require(magrittr))) install.packages("magrittr", repos = repos, lib = R_LIBS[2])

library(magrittr)
library(subprocess)

# retry start

if (file.exists(user_data.path <- file.path(system.file("", package = "swirl"), "user_data"))) {
  unlink(user_data.path, recursive = TRUE, force = TRUE)
}
dir.create(file.path(user_data.path, "wush"), recursive = TRUE)

.env <- Sys.getenv()
.env[["R_LIBS"]] <- paste(R_LIBS, collapse = ":")
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
    if (retry > 600) stop(sprintf("wait_until timeout"))
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
  if(length(.) != 1) {
    cat("search_selection error:\n", file = stderr())
    cat("\n\n==txt==\n\n", file = stderr())
    cat(txt, sep = "\n", file = stderr())
    cat("\n\n==ans==\n\n", file = stderr())
    cat(ans, sep = "\n", file = stderr())
    stop("")
  }
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
  enter_process("cat(.)")
  p.buf$R_USER_LIBS <- tail(p.buf$output, 1)[[1]]$stdout
  p.buf$R_USER_LIBS <- strsplit(p.buf$R_USER_LIBS, split = ">", fixed = TRUE)[[1]][1]
  p.buf$R_USER_LIBS <- base::trimws(p.buf$R_USER_LIBS)
  enter_process("dir.create(.)")
  enter_process(sprintf("lapply(dir('%s', full.names=TRUE), file.copy, ., recursive = TRUE)", R_USER_LIBS))
  enter_process(".libPaths(new = c(., .libPaths()))")
  enter_process("library(swirl)\n")
  enter_process("delete_progress('wush')\n")
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
tryCatch({
  wait_until(function(.) any(grepl("> ", ., fixed = TRUE)))
  enter_swirl()
  system.file("Courses/DataScienceAndR", package = "swirl") %>% 
    dir() %>% 
    grep(pattern = COURSE_PREFIX, value = TRUE) %>%
    lapply(enter_course)
}, finally = {
  targets <- dir(p.buf$R_USER_LIBS, full.names = TRUE)
  # remove locked files
  . <- regmatches(targets, regexec("00LOCK-(.*)$", targets))
  . <- Filter(f = function(.) length(.) == 2, .)
  if (length(.) > 0) {
    locked.pkg <- .[[1]][2]
    unlink(file.path(p.buf$R_USER_LIBS, locked.pkg), recursive = TRUE)
    unlink(file.path(p.buf$R_USER_LIBS, sprintf("00LOCK-%s", locked.pkg)), recursive = TRUE)
    targets <- dir(p.buf$R_USER_LIBS, full.names = TRUE)
  }
  lapply(targets, file.copy, R_USER_LIBS, overwrite = FALSE, recursive = TRUE)
  process_terminate(p)
})
