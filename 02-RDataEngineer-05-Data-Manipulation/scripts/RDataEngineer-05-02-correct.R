answer02 <- local({
  # 請從flights篩選出dep_delay > 0的資料
  target <- filter(flights, dep_delay > 0)
  nrow(target)
})
