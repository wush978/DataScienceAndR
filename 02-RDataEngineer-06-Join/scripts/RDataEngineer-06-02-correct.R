# 請同學使用`left_join`將`weather`的資訊貼到`flights`資料中
#   合併的過程請使用 year:day, hour, origin 當成合併的key
#   提示：請檢查weather與flights的欄位名稱重複的部分
# 比對完畢後，請先做資料的清理：
# - 結果只包含wind_speed與arr_delay這兩個欄位
# - 並且這些欄位中都不應該有NA或NaN
answer02.1 <- local({
  select(flights, year:day, hour, origin, dest, tailnum, carrier, arr_delay) %>%
    left_join(weather) %>%
    select(wind_speed, arr_delay) %>%
    filter(!is.na(wind_speed), !is.na(arr_delay))
})

stopifnot(nrow(answer02.1) == switch(packageVersion("nycflights13"), "0.1" = 116774, "0.2.0" = 326116, stop("Invalid nycflights13 version")))
stopifnot(sum(is.na(answer02.1$wind_speed)) == 0)
stopifnot(sum(is.nan(answer02.1$wind_speed)) == 0)
stopifnot(sum(is.na(answer02.1$arr_delay)) == 0)
stopifnot(sum(is.nan(answer02.1$arr_delay)) == 0)

# 接著我們要把風速（wind_speed)做分級。
# 由於我們對氣象的數據沒有背景知識，所以最好的分類方法就是透過數據的比率來抓。
# quantile函數會抓出一個數值向量中的百分位數，也就是說：
# answer02.2[1]會超過 0% 的 answer02.2
# answer02.2[2]會超過 25% 的 answer02.2
# answer02.2[3]會超過 50% 的 answer02.2
# answer02.2[4]會超過 75% 的 answer02.2
# answer02.2[5]會超過 100% 的 answer02.2
answer02.2 <- quantile(answer02.1$wind_speed, seq(0, 1, by = 0.25))
stopifnot(length(answer02.2) == 5)
stopifnot(answer02.2[1] == 0)
stopifnot(answer02.2[5] == max(answer02.2))

# 最後，我們利用`cut`與`answer02.2`對原始的wind_speed做分類。
# 介於 answer02.2[1]至answer02.2[2]的風速，會被歸類為等級1
# 介於 answer02.2[2]至answer02.2[3]的風速，會被歸類為等級2
# 介於 answer02.2[3]至answer02.2[4]的風速，會被歸類為等級3
# 介於 answer02.2[4]至answer02.2[5]的風速，會被歸類為等級4
# 接著，我們計算arr_delay在每一種分類中的平均數
answer02.3 <- local({
  mutate(answer02.1, wind_speed = cut(wind_speed, breaks = c(answer02.2[1]-1e-5, tail(answer02.2, -1)))) %>%
    group_by(wind_speed) %>%
    summarise(mean(arr_delay))
})
stopifnot(nrow(answer02.3) == 4)
stopifnot(colnames(answer02.3) == c("wind_speed", "mean(arr_delay)"))
if (packageVersion("nycflights13") != "0.2.0") stopifnot(answer02.3[[2]] > 4)
stopifnot(answer02.3[[2]] < 16)
# 請同學完成後回到console輸入`submit()`做檢查
