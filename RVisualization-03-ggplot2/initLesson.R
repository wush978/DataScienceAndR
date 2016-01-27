# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.
hsb <- read.csv(.get_path("hsb.csv"), header = TRUE)
.population.path <- tempfile(fileext = ".csv")
population <- local({
  cat("Loading data from opendata10412M030.csv...\n")
  population.src <- readLines(file(.get_path("opendata10412M030.csv"), encoding = "UTF-8"))
  write(population.src[-2], .population.path)
  population.src <- read.csv(.population.path, header = TRUE,
    colClass = c("integer", "character", "character", "integer", "integer", "integer", "integer", rep("integer", 202)
    ))
  df0 <- population.src[,2:3]
  cat("Constructing population dataset...\n")
  tmp <- lapply(0:100, function(age) {
    tmp2 <- lapply(c("m", "f"), function(sex) {
      name <- ifelse(age == 100,
                     sprintf("people_age_100up_%s", sex),
                     sprintf("people_age_%03d_%s", age, sex))
      df <- df0
      df$age <- age
      df$sex <- sex
      df$count <- population.src[[name]]
      df
    })
    do.call(rbind, tmp2)
  })
  do.call(rbind, tmp)
})
invisible(gc())
population_src <- function() {
  browseURL("http://data.moi.gov.tw/MoiOD/Data/DataDetail.aspx?oid=F4478CE5-7A72-4B14-B91A-F4701758328F")
}
suppressWarnings(try(rm(list = ".start_rvisualization_03", envir = globalenv()), silent = TRUE))
.hw_description <- readLines(file(.get_path(".hw_description.txt"), encoding = "UTF-8"))

begin_rvisualization_03 <- function() { }
hw_01 <- function() {
  g <-
    group_by(population, age) %>%
    summarise(count = sum(count)) %>%
    arrange(age) %>%
    ggplot(aes(x = age, y = count)) +
    geom_point() + geom_line()
  print(g)
  invisible(NULL)
}

hw_02 <- function() {
  cat(.hw_description[1]);cat("\n")
  g <-
    filter(population, site_id == .hw_description[2], village == .hw_description[5]) %>%
    group_by(village, sex) %>%
    summarise(count = sum(count)) %>%
    ggplot(aes(x = village, y = count, fill = sex)) +
    geom_bar(position = "dodge", stat = "identity")
  print(g)
}

hw_03 <- function() {
  cat(.hw_description[3]);cat("\n")
  g <-
    filter(population, site_id == .hw_description[4], village == .hw_description[5]) %>%
    ggplot(aes(x = age, y = count, color = sex)) +
    geom_point() + geom_line()
  print(g)
}
