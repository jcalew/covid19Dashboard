library(httr)
library(tidyverse)
library(flexdashboard)
library(DT)
library(tibbletime)
library(RCurl)

# using manual url until issue is fixed
##url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time() - 12, "%Y-%m-%d"), ".xlsx", sep = "")

# manually change this url to update
url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-2020-04-02.xlsx")

# download the dataset to a local temporary file
GET(url, write_disk(tf <- tempfile(fileext = ".xlsx")))

# read the Dataset sheet into “R”
df <- read_excel(tf)

# create United State dataframe
US_df <- df %>%
 filter(geoId == "US") %>%
  arrange(desc(dateRep))