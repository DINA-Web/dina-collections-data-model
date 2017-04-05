#!/usr/bin/Rscript

import <- function(packages) {
  # Installs missing R package(s), if required from SUNET repo    
  kSUNET <- "http://ftp.sunet.se/mirror/CRAN/"  
  
  getPackage <- function(package) {
    available <- suppressPackageStartupMessages(
      suppressMessages(suppressWarnings(
        require(package, character.only = TRUE, 
                quietly = TRUE, warn.conflicts = FALSE))))
    if (!available) {
      # the package is not available, so try to install and load it
      res <- tryCatch({ 
        install.packages(package, repos = kSUNET)
        loaded <- suppressPackageStartupMessages(
          suppressMessages(suppressWarnings(
            require(package, character.only = TRUE, 
                    quietly = TRUE, warn.conflicts = FALSE))))
      }, error = function(e) {
        loaded <- FALSE
      })
    } else loaded <- TRUE
    return(loaded)
  }  
  res <- sapply(packages, getPackage)  
}

                                 
import(c("rvest", "httr", "readr", "dplyr", "argparser", "selectr"))

p <- arg_parser(paste0("Case insensitive scan for reserved", 
  "words in liquibase sql statements...."))

p <- add_argument(p, "--stopwords", 
  help = "input file or url with liquibase sql",
  default = paste0("https://www.drupal.org/docs/develop/",
    "coding-standards/list-of-sql-reserved-words"))

p <- add_argument(p, "--input", 
  help = "file or url with checklist of stopwords", 
  default = paste0("https://raw.githubusercontent.com/chicoreus",
    "/cco_poc/master/src/main/resources/edu/harvard/huh/",
    "specify/datamodel/cco_full/db/tables.sql"))

p <- add_argument(p, "--verbose", 
  help = "provide more details",
  flag = TRUE)

argv <- parse_args(p)

if (argv$help) {
  print(p)
  if (!interactive()) q(status = 0)
}

if (argv$verbose) {
  message("Using stopwords in ", argv$stopwords)
  message("Using input liquibase sql in ", argv$input)
}

words <- 
  content(GET(argv$stopwords)) %>%
  html_nodes(css = "ol li") %>% 
  html_text

sql <- tolower(read_lines(argv$input))

re_tables <- "create table (\\w+) [(]"
re_fields <- "\\s+ (\\w+) (\\w+).*"

parse_liquibase_sql <- function(re, sql) {
  gsub(re, "\\1", grep(re, sql, value = TRUE))
}

tables <- parse_liquibase_sql(re_tables, sql)
fields <- parse_liquibase_sql(re_fields, sql)
terms <- unlist(strsplit(c(tables, fields), "_"))

if (argv$verbose)
  message(paste0("Beginning scan of table names, ", 
     "field/column names and terms ", 
     "(splitting composite names by '_')"))

find_stopwords <- function(x) {
  intersect(tolower(x), tolower(words))
}

stop_tables <- find_stopwords(tables)
stop_fields <- find_stopwords(fields)
stop_terms <- find_stopwords(terms)

# if (argv$verbose) {
#   message("Using stopwords: ",
#     paste(collapse = ", ", tolower(words)), "\n")
# }

if (length(stop_tables) > 0)
  message("Inappropriate tables:\n\t", 
          paste(collapse = "\n\t", stop_tables))

if (length(stop_fields) > 0)
  message("Inappropriate fields/columns:\n\t", 
          paste(collapse = "\n\t", stop_fields))

if (length(stop_terms) > 0 & argv$verbose)
  message("Inappropriate terms in composite strings:\n\t", 
          paste(collapse = "\n\t", stop_terms))

if (argv$verbose) message("Done")
