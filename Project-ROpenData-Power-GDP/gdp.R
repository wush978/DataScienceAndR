gdp <- readLines(file("NA8103A1Ac.csv", encoding = "BIG-5"))
gdp <- gsub('"', '', gdp)
year <- 2007:2013
gdp.year.start <- sapply(year, function(year) {
  which(gdp == year)
})
gdp.year.end <- c(tail(gdp.year.start - 1, -1), length(gdp))
gdp.df.all <- list()
for(i in seq_along(year)) {
  index <- seq(
    gdp.year.start[i],
    gdp.year.end[i],
    by = 1)
  gdp.split <- strsplit(gdp[index], ",")
  gdp.split <- gdp.split[sapply(gdp.split, length) == 3]
  gdp.split <- gdp.split[sapply(gdp.split, `[`, 1) == " "]
  gdp.mat <- do.call(rbind, gdp.split)
  gdp.df <- as.data.frame(gdp.mat[,-1], stringsAsFactors = FALSE)
  colnames(gdp.df) <- c("name", "gdp")
  gdp.df$name <- as.character(gdp.df$name)
  gdp.df$gdp <- as.numeric(gdp.df$gdp)
  gdp.split <- strsplit(gdp.df$name, ".", fixed = TRUE)
  gdp.df <- gdp.df[sapply(gdp.split, length) == 2,]
  gdp.split <- strsplit(gdp.df$name, ".", fixed = TRUE)
  gdp.df$id <- sapply(gdp.split, `[`, 1)
  gdp.df$year <- year[i]
  gdp.df.all[[i]] <- gdp.df
}
gdp.df <- do.call(rbind, gdp.df.all)
gdp.df
