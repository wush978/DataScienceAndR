# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

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
