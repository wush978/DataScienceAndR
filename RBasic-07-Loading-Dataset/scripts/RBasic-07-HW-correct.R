#' 請同學用這章節所學的技巧，讀取`orglist.path`的檔案
#' 資料來源：<http://data.gov.tw/node/7307>

# <你可以在這裡做各種嘗試>
answer.raw <- readBin(orglist.path, what = "raw", n = file.info(orglist.path)$size)
answer.txt <- stringi::stri_encode(answer.raw, from = "UTF-16", to = "UTF-8")
answer <- read.table(textConnection(answer.txt, encoding = "UTF-8"), header = TRUE, sep = ",")
