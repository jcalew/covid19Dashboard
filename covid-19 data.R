library(httr)
library(readxl)
library(tidyverse)
library(flexdashboard)
library(DT)

url1 <- paste0("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",Sys.Date(),".xls")

GET(url1, write_disk(tf <- tempfile(fileext = ".xls")))

df <- read_excel((tf))