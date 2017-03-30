youbike1 <- fromJSON(youbike_path)

sna1 <- youbike1$result$results$sna
lat1 <- youbike1$result$results$lat
lng1 <- youbike1$result$results$lng
tot1 <- youbike1$result$results$tot
sbi1 <- youbike1$result$results$sbi

rm(youbike1) # 刪除youbike
youbike2 <- fromJSON(youbike_path, simplifyDataFrame = FALSE)
results <- youbike2$result$results
#' `sapply(results, "[[", "sna")`，在R中等價於以下的函數:
#' sapply(results, function(element) {
#'   element[["sna"]]
#' })
sna2 <- sapply(results, "[[", "sna")
lat2 <- sapply(results, "[[", "lat")
lng2 <- sapply(results, "[[", "lng")
tot2 <- sapply(results, "[[", "tot")
sbi2 <- sapply(results, "[[", "sbi")

answer <- data.frame(stringsAsFactors = FALSE,
  sna = sna2,
  lat = as.numeric(lat2),
  lng = as.numeric(lng2),
  tot = as.integer(tot2),
  sbi = as.integer(sbi2)
)

stopifnot(nrow(answer) == 10)
stopifnot(isTRUE(all.equal(sum(answer$lat), 250.35549511)))
stopifnot(isTRUE(all.equal(sum(answer$lng), 1215.65644412)))
stopifnot(sum(answer$tot) == 702)
stopifnot(sum(answer$sbi) == 0)
