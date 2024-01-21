## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)



## ----setup--------------------------------------------------------------------


## -----------------------------------------------------------------------------
library(sqlhelper)

conf_fn <- "examples/sqlhelper_db_conf.yml"

readLines(conf_fn) |>
  writeLines()

connect(conf_fn)

## -----------------------------------------------------------------------------

# Write iris to sqlhelper's default connection
DBI::dbWriteTable(default_conn(), name = "IRIS", value = iris)

# write some queries in a .sql file
file_to_run <- "examples/example.sql"

readLines(file_to_run) |> writeLines()

#Define a parameter
petal_length <- 1.3

# Run the queries and save the results
results <- run_files(file_to_run)

# Inspect the results. By default, run_files() returns a list of the results of 
# each query in the files you provided. Results of a specific query can be accessed by the
# the name of the query. See the article 'Executing SQL' for more on named queries.
results

results$short_petal_setosa

## -----------------------------------------------------------------------------
# write some queries
my_queries <- c( 
  showtabs = "SELECT name FROM sqlite_schema WHERE type ='table' AND name NOT LIKE 'sqlite_%'",
  how_many_irises = "select count(*) from iris"
)

# Run the queries and save the results
results <- run_queries(my_queries)

# Inspect the results. runqueries() returns a list with one element per query.
# You can access them using the names of the queries:
results$showtabs

results$how_many_irises

