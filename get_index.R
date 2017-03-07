
insert <- function(src, position, element, after = TRUE) {
  if (after) {
    c(
      src[1:position],
      element,
      tail(src, -position)
    )
  } else stop("TODO")
}

src <- readLines("README.html")
.x <- src[.i <- grep("<h1>R語言翻轉教室</h1>", src, fixed = TRUE)]
.x <- gsub("<h1>R語言翻轉教室</h1>", '<h1><img src="http://i.imgur.com/81C5LBk.png?v=1" style="height:7em" /></h1>', .x)
src[.i] <- .x
src <- insert(src, which.max(grepl("<link", src)), '<link rel="icon" href="http://i.imgur.com/RkG7X4l.png?v=1" />')
cat(src, file = "index.html", sep = "\n")
