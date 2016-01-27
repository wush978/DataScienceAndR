src <- readLines(file(pirate_path, encoding = "BIG5"))
tmp <- strsplit(src, "：")
key <- sapply(tmp, "[[", 1)
is_target <- key == "經緯度"
value <- sapply(tmp[is_target], "[[", 2)
pirate <- data.frame(
  lat = substring(value, 3, 4) %>% as.numeric + substring(value, 6, 7) %>% as.numeric / 60,
  log = substring(value, 12, 14) %>% as.numeric + substring(value, 16, 17) %>% as.numeric / 60)
g + geom_point(aes(x = log, y = lat), data = pirate)
