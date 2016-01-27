# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.
hsb <- read.csv(.get_path("hsb.csv"), header = TRUE)
population <- local({
  cat("Loading data from opendata10412M030.csv...\n")
  population.src <- read.csv(file(.get_path("opendata10412M030.csv"), encoding = "UTF-8"), skip = 2, header = FALSE)
  colnames(population.src) <- c("statistic_yyymm", "site_id", "village", "household_no", "people_total",
  "people_total_m", "people_total_f", "people_age_000_m", "people_age_000_f",
  "people_age_001_m", "people_age_001_f", "people_age_002_m", "people_age_002_f",
  "people_age_003_m", "people_age_003_f", "people_age_004_m", "people_age_004_f",
  "people_age_005_m", "people_age_005_f", "people_age_006_m", "people_age_006_f",
  "people_age_007_m", "people_age_007_f", "people_age_008_m", "people_age_008_f",
  "people_age_009_m", "people_age_009_f", "people_age_010_m", "people_age_010_f",
  "people_age_011_m", "people_age_011_f", "people_age_012_m", "people_age_012_f",
  "people_age_013_m", "people_age_013_f", "people_age_014_m", "people_age_014_f",
  "people_age_015_m", "people_age_015_f", "people_age_016_m", "people_age_016_f",
  "people_age_017_m", "people_age_017_f", "people_age_018_m", "people_age_018_f",
  "people_age_019_m", "people_age_019_f", "people_age_020_m", "people_age_020_f",
  "people_age_021_m", "people_age_021_f", "people_age_022_m", "people_age_022_f",
  "people_age_023_m", "people_age_023_f", "people_age_024_m", "people_age_024_f",
  "people_age_025_m", "people_age_025_f", "people_age_026_m", "people_age_026_f",
  "people_age_027_m", "people_age_027_f", "people_age_028_m", "people_age_028_f",
  "people_age_029_m", "people_age_029_f", "people_age_030_m", "people_age_030_f",
  "people_age_031_m", "people_age_031_f", "people_age_032_m", "people_age_032_f",
  "people_age_033_m", "people_age_033_f", "people_age_034_m", "people_age_034_f",
  "people_age_035_m", "people_age_035_f", "people_age_036_m", "people_age_036_f",
  "people_age_037_m", "people_age_037_f", "people_age_038_m", "people_age_038_f",
  "people_age_039_m", "people_age_039_f", "people_age_040_m", "people_age_040_f",
  "people_age_041_m", "people_age_041_f", "people_age_042_m", "people_age_042_f",
  "people_age_043_m", "people_age_043_f", "people_age_044_m", "people_age_044_f",
  "people_age_045_m", "people_age_045_f", "people_age_046_m", "people_age_046_f",
  "people_age_047_m", "people_age_047_f", "people_age_048_m", "people_age_048_f",
  "people_age_049_m", "people_age_049_f", "people_age_050_m", "people_age_050_f",
  "people_age_051_m", "people_age_051_f", "people_age_052_m", "people_age_052_f",
  "people_age_053_m", "people_age_053_f", "people_age_054_m", "people_age_054_f",
  "people_age_055_m", "people_age_055_f", "people_age_056_m", "people_age_056_f",
  "people_age_057_m", "people_age_057_f", "people_age_058_m", "people_age_058_f",
  "people_age_059_m", "people_age_059_f", "people_age_060_m", "people_age_060_f",
  "people_age_061_m", "people_age_061_f", "people_age_062_m", "people_age_062_f",
  "people_age_063_m", "people_age_063_f", "people_age_064_m", "people_age_064_f",
  "people_age_065_m", "people_age_065_f", "people_age_066_m", "people_age_066_f",
  "people_age_067_m", "people_age_067_f", "people_age_068_m", "people_age_068_f",
  "people_age_069_m", "people_age_069_f", "people_age_070_m", "people_age_070_f",
  "people_age_071_m", "people_age_071_f", "people_age_072_m", "people_age_072_f",
  "people_age_073_m", "people_age_073_f", "people_age_074_m", "people_age_074_f",
  "people_age_075_m", "people_age_075_f", "people_age_076_m", "people_age_076_f",
  "people_age_077_m", "people_age_077_f", "people_age_078_m", "people_age_078_f",
  "people_age_079_m", "people_age_079_f", "people_age_080_m", "people_age_080_f",
  "people_age_081_m", "people_age_081_f", "people_age_082_m", "people_age_082_f",
  "people_age_083_m", "people_age_083_f", "people_age_084_m", "people_age_084_f",
  "people_age_085_m", "people_age_085_f", "people_age_086_m", "people_age_086_f",
  "people_age_087_m", "people_age_087_f", "people_age_088_m", "people_age_088_f",
  "people_age_089_m", "people_age_089_f", "people_age_090_m", "people_age_090_f",
  "people_age_091_m", "people_age_091_f", "people_age_092_m", "people_age_092_f",
  "people_age_093_m", "people_age_093_f", "people_age_094_m", "people_age_094_f",
  "people_age_095_m", "people_age_095_f", "people_age_096_m", "people_age_096_f",
  "people_age_097_m", "people_age_097_f", "people_age_098_m", "people_age_098_f",
  "people_age_099_m", "people_age_099_f", "people_age_100up_m",
  "people_age_100up_f")
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
