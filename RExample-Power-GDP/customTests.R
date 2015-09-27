# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

test_package_version <- function(pkg_name, pkg_version) {
  e <- get("e", parent.frame())
  tryCatch(
    packageVersion(pkg_name) >= package_version(pkg_version),
    error = function(e) FALSE)
}

test_search_path <- function(pkg_name) {
  tryCatch(
    length(grep(sprintf("/%s$", pkg_name), searchpaths())) > 0,
    error = function(e) FALSE)
}

test_var_value <- function(var_name, expected_value) {
  e <- get("e", parent.frame())
  var <- get(var_name, globalenv())
  isTRUE(all.equal(var, expected_value))
}

.get_path <- function(fname) {
  file.path(find.package("swirl", quiet = TRUE), sprintf("Courses/DataScienceAndR/RExample-Power-GDP/%s", fname))
}

test_generator <- function(user_name, rds_path) {
  function() {
    user_object <- get(user_name, globalenv())
    rds <- readRDS(.get_path(rds_path))
    isTRUE(all.equal(user_object, rds))
  }
}

test_power <- test_generator("power", "power.Rds")

test_power_split <- test_generator("power.split", "power.split.Rds")

test_power_df_column <- function(name) {
  power.df <- get("power.df", globalenv())
  switch(name,
         id = {class(power.df[[name]])[1] == "character"},
         name = {class(power.df[[name]])[1] == "factor"},
         year = {class(power.df[[name]])[1] == "integer"},
         power = {class(power.df[[name]])[1] == "numeric"}
  )
}

test_power_df <- test_generator("power.df", "power.df.Rds")

test_gdp_df <- test_generator("gdp.df", "gdp.df.Rds")
