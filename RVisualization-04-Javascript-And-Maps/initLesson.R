# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("hsb", read.csv(.get_path("hsb.csv"), header = TRUE), envir = globalenv())

assign("dat_sk", data.frame(From=c(rep("A",3), rep("B", 3)),
                  To=c(rep(c("X", "Y", "Z"),2)),
                  Weight=c(5,7,6,2,9,4)), envir = globalenv())

assign("TWII", local({
  retval <- read.csv(.get_path("TWII.csv"))
  retval$date <- as.Date(retval$date)
  retval
}), envir = globalenv())

assign("eq", read.csv(.get_path("eq.csv")), envir = globalenv())

assign("pirate_path",
       .get_path("pirate-info-2015-09.txt"),
       envir = globalenv())

assign("hw", function() {
  src <- readLines(file(pirate_path, encoding = "BIG5"))
  tmp <- strsplit(src, readLines(.get_path(".hw")[2]))
  key <- sapply(tmp, "[[", 1)
  is_target <- key == readLines(.get_path(".hw")[1])
  value <- sapply(tmp[is_target], "[[", 2)
  pirate <- data.frame(
    lat = substring(value, 3, 4) %>% as.numeric + substring(value, 6, 7) %>% as.numeric / 60,
    log = substring(value, 12, 14) %>% as.numeric + substring(value, 16, 17) %>% as.numeric / 60)
  print(g + geom_point(aes(x = log, y = lat), data = pirate))
}, envir = globalenv())
