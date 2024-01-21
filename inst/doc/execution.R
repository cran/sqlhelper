## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----execute_file-------------------------------------------------------------
library(sqlhelper)
connect("examples/sqlhelper_db_conf.yml", exclusive = TRUE)
DBI::dbWriteTable( default_conn(), name = "IRIS", iris)

readLines("examples/example.sql") |>
writeLines()

petal_length <- 1.3

results <- run_files("examples/example.sql")

results

## ----named_access-------------------------------------------------------------
results$short_petal_setosa

## ----interpreted_comments-----------------------------------------------------
## add combined standard/spatial example

## ----cascade------------------------------------------------------------------
## cascaded comments example

## -----------------------------------------------------------------------------
readLines("examples/petal_length_params.sql") |>
  writeLines()

petal_length = 1.2

run_files("examples/petal_length_params.sql")

## ----values-------------------------------------------------------------------
# reusing the petal length parameter example
# A user may have a petal_length parameter in the globalenv already
print(petal_length)
result_from_globalenv <-
  run_files("examples/petal_length_params.sql")
result_from_globalenv$short_petal_setosa

# a bespoke environment can provide a specific set of values for interpolation
my_values <- new.env()
my_values$petal_length <- 1.4
result_from_my_values <-
  run_files("examples/petal_length_params.sql", values = my_values)
result_from_my_values$short_petal_setosa

## ----binding------------------------------------------------------------------
readLines("examples/binding.SQL") |>
  writeLines()

petal_width <- 0.2

result <- run_files("examples/binding.SQL")

DBI::dbBind(result$binding_example, list("setosa"))

DBI::dbFetch(result$binding_example)

DBI::dbClearResult(result$binding_example)


## ----conns--------------------------------------------------------------------

con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

cars <- mtcars
cars$model <- row.names(mtcars)
DBI::dbWriteTable(con, "cars", cars)

minmpg = 30

run_queries("SELECT model, mpg, cyl FROM CARS WHERE mpg >= {minmpg}",
            default.conn = con)


