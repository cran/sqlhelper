## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----connect------------------------------------------------------------------
library(sqlhelper)

connect("examples/sqlhelper_db_conf.yml")

## ----config-------------------------------------------------------------------
readLines("examples/sqlhelper_db_conf.yml") |>
  writeLines()

## ----connection_info----------------------------------------------------------
connection_info()

## -----------------------------------------------------------------------------
myconn <- live_connection("simple_sqlite")
myconn

## -----------------------------------------------------------------------------
get_default_conn_name()

set_default_conn_name("pool_sqlite")

get_default_conn_name()

get_default_conn_name() |>
  live_connection()

## -----------------------------------------------------------------------------
conn_name <- "simple_sqlite"

is_connected(conn_name)
connection_info(conn_name)$live

myconn <- live_connection(conn_name)
DBI::dbDisconnect(myconn)

connection_info()

if(not_connected(conn_name)){
  message(glue::glue("{conn_name} is not available, reconnecting..."))
  connect("examples/sqlhelper_db_conf.yml", exclusive = TRUE)
}

connection_info()

disconnect()

connection_info()

