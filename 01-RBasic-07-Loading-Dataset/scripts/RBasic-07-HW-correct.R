#' 請同學用這章節所學的技巧，讀取`orglist.path`的檔案
#' 資料來源：<http://data.gov.tw/node/7307>

# <你可以在這裡做各種嘗試>
answer.raw <- readBin(orglist.path, what = "raw", n = file.info(orglist.path)$size)
answer.txt <- stringi::stri_encode(answer.raw, from = "UTF-16", to = "UTF-8")
get_text_connection_by_l10n_info <- function(x) {
  info <- l10n_info()
  if (info$MBCS & !info$`UTF-8`) {
    textConnection(x)
  } else {
    textConnection(x, encoding = "UTF-8")
  }
}
answer <- read.table(get_text_connection_by_l10n_info(answer.txt), header = TRUE, sep = ",")
