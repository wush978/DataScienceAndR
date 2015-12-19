#' 這份作業請同學先安裝套件 XML

library(tm)
crude.path <- system.file("texts", "crude", package = "tm")
crude <- VCorpus(DirSource(crude.path), readerControl = list(reader = readReut21578XMLasPlain))

#' 請依序利用tm_map 和以下函數對crude做清理之後，建立TermDocumentMatrix
#' 1) stripWhitespace
#' 2) content_transformer(tolower)
#' 3) removeWords 搭配參數 stopwords("english")

crude.tdm <- {
  NULL
  # 你的程式碼
}

#' 預期的結果的dimension
stopifnot(dim(crude.tdm) == c(1183, 20))