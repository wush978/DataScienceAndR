# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rdataengineer_02_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("tender", "ths", "ths_text", "is_target", "ths2",
                 "trs", "trs_children", "trs_children_text")
  tender.ref <- read_html(tender_path)
  ths.ref <- xml_find_all(tender.ref, "//tr/th")
  ths_text.ref <- xml_text(ths.ref)
  Encoding(ths_text.ref) <- "UTF-8"
  player_name_reference <- rawToChar(as.raw(c(227L, 128L, 128L, 229L, 187L, 160L, 229L, 149L, 134L, 229L,
    144L, 141L, 231L, 168L, 177L)))
  is_target.ref <- ths_text.ref == player_name_reference
  ths2.ref <- ths.ref[is_target.ref]
  trs.ref <- xml_parent(ths2.ref)
  trs_children.ref <- xml_children(trs.ref)
  trs_children_text.ref <- xml_text(trs_children.ref)
  Encoding(trs_children_text.ref) <- "UTF-8"
  players.ref <- trs_children_text.ref[trs_children_text.ref != player_name_reference]
  tryCatch({
    for(name in name.list) {
      .src <- get(name, envir = globalenv())
      .ref <- get(sprintf("%s.ref", name))
      if (class(.src)[1] %in% c("xml_document", "xml_nodeset", "xml_node")) {
        if (!isTRUE(all.equal(xml_text(.src), xml_text(.ref)))) stop(sprintf("%s is wrong! Try again.\n", name))
      } else {
        if (!isTRUE(all.equal(.src, .ref))) stop(sprintf("%s is wrong! Try again.\n", name))
      }
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })

}
