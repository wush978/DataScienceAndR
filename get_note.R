library(magrittr)
library(yaml)
library(git2r)

repo_tmp_dir <- tempfile(pattern = "DataScienceAndR")
repo <- clone(".", local_path = repo_tmp_dir)
remote_add(repo, "wush978", "https://github.com/wush978/DataScienceAndR.git")
fetch(repo, "wush978")
checkout(repo, branch = "course")
.tmp <- remote_ls("wush978", repo)
stopifnot(.tmp["refs/heads/course"] == branch_target(head(repo)))

course_list <- dir(repo_tmp_dir, "lesson.yaml", full.names = TRUE, recursive = TRUE)
get_lecture_note <- function(course, out_dir = tempdir()) {
  
  from_text <- function(level, i) {
sprintf("

## 關卡 %d

%s

", i, gsub("\\s", "", level$Output))
  }

  from_cmd_question <- function(level, i) {
sprintf("

## 關卡 %d

%s

```r
%s
```

", i, gsub("\\s", "", level$Output), level$CorrectAnswer)
  }
  
  from_mult_question <- function(level, i) {
sprintf("

## 關卡 %d

%s

%s
", i, gsub("\\s", "", level$Output), level$CorrectAnswer)
  }
  
  from_script <- function(level, i) {
    script_path <- file.path(dirname(course), "scripts", level$Script)
    correct_script_path <- file.path(dirname(course), "scripts", gsub(".R", "-correct.R", level$Script, fixed = TRUE))
    if (file.exists(correct_script_path)) {
      script <- readLines(correct_script_path)
    } else {
      script <- readLines(script_path)
    }
    script <- script %>%
      paste(collapse = "\n")
sprintf("

## 關卡 %d

%s

```r
%s
```

", i, gsub("\\s", "", level$Output), script)
  }
    
  content <- yaml.load_file(course)
  retval <- character(0)
  for(i in seq_along(content) %>% tail(-1)) {
    operator <- get(sprintf("from_%s", content[[i]]$Class))
    retval %<>% append(operator(content[[i]], i - 1))
  }
  rmd_file <- tempfile(fileext = ".Rmd")
  write(retval, file = rmd_file)
  md_file <- tempfile(fileext = ".md")
  knitr::knit(rmd_file, md_file)
  # browser()
  html_file <- file.path(out_dir, sprintf("%s.html", dirname(course) %>% basename())) %>%
    gsub(pattern = "/./", replacement = "/", fixed = TRUE) %>%
    gsub(pattern = "^\\.", replacement = getwd()) %>%
    normalizePath(mustWork = FALSE)
#   html_file <- tempfile(fileext = ".html")
#   browser()
  rmarkdown::render(md_file, "html_document", html_file)
  invisible(html_file)
}

if (!file.exists("note")) dir.create("note")
htmls <- character(0)
for(i in seq_along(course_list)) {
  htmls %<>% append(get_lecture_note(course_list[i], "./note"))
}

readme.src <- readLines("README-src.md")
readme.src <- 
  sprintf("- [%s](%s)", basename(htmls) %>% tools::file_path_sans_ext(), file.path("note", basename(htmls))) %>%
  paste(collapse = "\n") %>%
  gsub(pattern = "<r-note>", x = readme.src, fixed = TRUE)

readme.src <- 
  branch_target(head(repo)) %>%
  substring(1, 8) %>%
  gsub(pattern = "<r-sha-hash>", x = readme.src, fixed = TRUE)

cat(readme.src, file = "README.md", append = FALSE, sep = "\n")
