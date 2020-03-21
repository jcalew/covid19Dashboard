library(httr)
library(readxl)
library(tidyverse)
library(flexdashboard)
library(DT)
library(lubridate)
library(tibbletime)

url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xls", sep = "")

GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx")))

df <- read_excel(tf)

US_df <- df %>%
 filter(GeoId == "US") %>%
  arrange(desc(DateRep))