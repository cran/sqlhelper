% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/disconnect.R
\name{disconnect}
\alias{disconnect}
\title{Close all connections and remove them from the connections cache}
\usage{
disconnect()
}
\value{
\code{NULL}, invisibly
}
\description{
Close all connections and remove them from the connections cache
}
\examples{
library(sqlhelper)
connect(
  system.file("examples",
              "sqlhelper_db_conf.yml",
              package="sqlhelper")
)
disconnect()
}
