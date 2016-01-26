# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.
hsb <- read.csv(.get_path("hsb.csv"), header = TRUE)
population <- read.csv(gzfile(.get_path("population.csv.gz"), encoding = "UTF-8"), header = TRUE)
population_src <- function() {
  browseURL("http://data.moi.gov.tw/MoiOD/Data/DataDetail.aspx?oid=F4478CE5-7A72-4B14-B91A-F4701758328F")
}
suppressWarnings(try(rm(list = ".start_rvisualization_03", envir = globalenv()), silent = TRUE))

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
  cat("新北市板橋區各里的人口分佈圖(依性別分類)\n")
  g <-
    filter(population, site_id == "新北市板橋區") %>%
    group_by(village, sex) %>%
    summarise(count = sum(count)) %>%
    ggplot(aes(x = village, y = count, fill = sex)) +
    geom_bar(dodge = FALSE, stat = "identity")
  print(g)
}

hw_03 <- function() {
  cat("新北市板橋區留侯里的年齡與人口分布圖(依性別分類)\n")
  g <-
    filter(population, site_id == "新北市板橋區", village == "留侯里") %>%
    ggplot(aes(x = age, y = count, color = sex)) +
    geom_point() + geom_line()
  print(g)
}
