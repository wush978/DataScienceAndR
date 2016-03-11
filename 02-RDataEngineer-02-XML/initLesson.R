# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("x1",
       "<a><b>B</b><c>C1</c><c class='x'>C2</c></a>",
       envir = globalenv())

assign("tender_path",
        .get_path("0080400004.html"),
        envir = globalenv())

wiki_dom <- function() {
  browseURL("https://zh.wikipedia.org/wiki/%E6%96%87%E6%A1%A3%E5%AF%B9%E8%B1%A1%E6%A8%A1%E5%9E%8B")
}

wiki_html <- function() {
  browseURL("https://zh.wikipedia.org/wiki/HTML")
}

wiki_xml <- function() {
  browseURL("https://zh.wikipedia.org/wiki/XML")
}

wiki_xpath <- function() {
  browseURL("https://zh.wikipedia.org/wiki/XPath")
}
