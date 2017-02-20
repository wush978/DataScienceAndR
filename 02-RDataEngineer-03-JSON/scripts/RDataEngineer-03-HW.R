# 我們已經先將存放youbike資料的路徑放置youbike_path中，
# 請先使用jsonlite的fromJSON載入youbike data。
youbike1 <- fromJSON(youbike_path)

# 請從youbike1中取出以下向量：

# 場站名稱(中文)。
sna1 <- {
  # 請在此填寫你的程式碼。
}
# 經度。
lng1 <- {
  # 請在此填寫你的程式碼。
}
# 緯度。
lat1 <- {
  # 請在此填寫你的程式碼。
}
# 總車位數。
tot1 <- {
  # 請在此填寫你的程式碼。
}
# 目前車輛數目。
sbi1 <- {
  # 請在此填寫你的程式碼。
}

stopifnot(length(sna1) == 10)
stopifnot(length(lng1) == 10)
stopifnot(length(lat1) == 10)
stopifnot(length(tot1) == 10)
stopifnot(length(sbi1) == 10)
stopifnot(class(sna1) == "character")
stopifnot(class(lng1) == "character")
stopifnot(class(lat1) == "character")
stopifnot(class(tot1) == "character")
stopifnot(class(sbi1) == "character")

rm(youbike1) # 刪除youbike。
# 為了比較一下，也為了確定同學能夠在simplifyDataFrame的條件不成立時，
# 仍然有能力從JSON中萃取資訊，所以我們關掉simplifyDataFrame，
# 請同學從`youbike2`中再挑出場站名稱(中文)、經緯度、總車位數和目前車輛數目。
youbike2 <- fromJSON(youbike_path, simplifyDataFrame = FALSE)

# 方便起見，我們先把results物件抽出來。
results <- youbike2$result$results
# 提示：可以用sapply搭配"[["。

# 場站名稱(中文)。
sna2 <- {
  # 請在此填寫你的程式碼。
}
# 精度。
lng2 <- {
  # 請在此填寫你的程式碼。
}
# 緯度。
lat2 <- {
  # 請在此填寫你的程式碼。
}
# 總車位數。
tot2 <- {
  # 請在此填寫你的程式碼。
}
# 目前車輛數目。
sbi2 <- {
  # 請在此填寫你的程式碼。
}

stopifnot(length(sna2) == 10)
stopifnot(length(lng2) == 10)
stopifnot(length(lat2) == 10)
stopifnot(length(tot2) == 10)
stopifnot(length(sbi2) == 10)
stopifnot(class(sna2) == "character")
stopifnot(class(lng2) == "character")
stopifnot(class(lat2) == "character")
stopifnot(class(tot2) == "character")
stopifnot(class(sbi2) == "character")

# 結果。
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
