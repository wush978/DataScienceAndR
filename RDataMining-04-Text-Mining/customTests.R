# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rdatamining_04_test <- function() {
  e <- get("e", parent.frame())
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("crude.tdm")
  crude.path <- system.file("texts", "crude", package = "tm")
  crude.tdm.ref <- local({
    crude <- VCorpus(DirSource(crude.path), readerControl = list(reader = readReut21578XMLasPlain))
    tmp <- tm_map(crude, stripWhitespace)
    tmp <- tm_map(tmp, content_transformer(tolower))
    tmp <- tm_map(tmp, removeWords, stopwords('english'))
    TermDocumentMatrix(tmp)
  })

  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}
