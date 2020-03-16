library(httr)
library(readxl)
library(tidyverse)
library(flexdashboard)

url1 <- "https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-2020-03-15.xls"

GET(url1, write_disk(tf <- tempfile(fileext = ".xls")))

df <- read_excel((tf))