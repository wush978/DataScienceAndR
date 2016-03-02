library(xml2)
library(RCurl)
library(httr)

data <- list()

get_url <- function(i = NULL) {
  if (is.null(i)) {
    url <- sprintf("https://www.ptt.cc/bbs/StupidClown/index.html") 
  } else {
    url <- sprintf("https://www.ptt.cc/bbs/StupidClown/index%d.html", i) 
  }
}

last_page <- htmlParse(getURL(get_url()))
topright <- getNodeSet(last_page, "//a[@class='btn wide']")
last_2nd_url <- xmlAttrs(topright[[2]])["href"]
last_2nd_index <- regmatches(last_2nd_url, regexec("index(\\d+).html$", last_2nd_url))[[1]][2]
size <- as.integer(last_2nd_index) + 1
for(i in tail(seq_len(size), 100)) {
  url.list <- xpathSApply(htmlParse(getURL(get_url(i))), "//div[@class='title']/a[@href]", xmlAttrs)
  data[[length(data) + 1]] <- paste0("www.ptt.cc", url.list)
  Sys.sleep(0.1)
}

data <- unlist(data)

get_doc <- function(article_url){
  name <- strsplit(article_url, '/')[[1]][4]
  if (!dir.exists("ptt-StupidClown")) dir.create("ptt-StupidClown")
  dst <- file.path("ptt-StupidClown", gsub('html', 'txt', name))
  is.done <- file.exists(dst)
  if (is.done) {
    is.done <- file.info(dst)$size > 1
  }
  if (!is.done) {
    response <- GET(sprintf("http://%s", article_url))
    Sys.sleep(0.1)
    stop_for_status(response)
    doc <- content(response, "parsed")
    xml_find_all(doc, "//div[@id='main-content']") %>%
      sapply(xml_text) %>%
      write(file = dst)
  }
}

pb <- txtProgressBar(max = length(data), style = 3)
for(i in seq_along(data)) {
  get_doc(data[i])
  setTxtProgressBar(pb, i)
}
close(pb)

library(tm)
library(tmcn)
library(jiebaR)
cutter <- worker()
d.corpus <- Corpus(DirSource("ptt-StupidClown/"), list(language = NA))
d.corpus <- tm_map(d.corpus, removePunctuation)
d.corpus <- tm_map(d.corpus, removeNumbers)
d.corpus <- tm_map(d.corpus, content_transformer(function(word) {
  gsub("[A-Za-z0-9]", "", word)
}))
# words <- readLines("ptt_bbs.txt")#, what = "raw", n = file.info("ptt_bbs.txt")$size)
# words <- toTrad(words)
# insertWords(sapply(strsplit(words, "\\s"), head, 1))
d.corpus <- tm_map(d.corpus, content_transformer(function(x) {
  cutter <= x
}))
myStopWords <- c(stopwordsCN(), "ç·¨è¼¯", "??????", "æ¨?é¡?", "??¼ä¿¡", "å¯¦æ¥­", "ä½????")
d.corpus <- tm_map(d.corpus, removeWords, myStopWords)
tdm <- TermDocumentMatrix(d.corpus, control = list(wordLengths = c(2, Inf)))
inspect(tdm[1:10, 1:2])
library(wordcloud)
m1 <- as.matrix(tdm)
v <- sort(rowSums(m1), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
wordcloud(d$word, d$freq, min.freq = 10, random.order = F, ordered.colors = F, 
          colors = rainbow(length(row.names(m1))))
d.dtm <- DocumentTermMatrix(d.corpus, control = list(wordLengths = c(2, Inf)))
inspect(d.dtm[1:10, 1:2])
findFreqTerms(d.dtm, 30)
findAssocs(d.dtm, "???å­?", 0.5)
