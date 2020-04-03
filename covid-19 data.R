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

# create death totals by country dataframe
deaths_by_country_df <- df %>%
  group_by(countriesAndTerritories) %>%
  summarise(deaths = sum(deaths)) %>%
  arrange(desc(deaths))

# create case totals by country dataframe
cases_by_country_df <- df %>%
  group_by(countriesAndTerritories) %>%
  summarise(cases = sum(cases)) %>%
  arrange(desc(cases))

# create United States dataframe
US_df <- df %>%
  filter(geoId == "US") %>%
  arrange(desc(dateRep))

# create Italy dataframe
Italy_df <- df %>%
  filter(geoId == "IT") %>%
  arrange(desc(dateRep))

# create Spain dataframe
Spain_df <- df %>%
  filter(geoId == "ES") %>%
  arrange(desc(dateRep))

# create Germany dataframe
Germany_df <- df %>%
  filter(geoId == "DE") %>%
  arrange(desc(dateRep))

# create China dataframe
China_df <- df %>%
  filter(geoId == "CN") %>%
  arrange(desc(dateRep))

# create France dataframe
France_df <- df %>%
  filter(geoId == "FR") %>%
  arrange(desc(dateRep))

# create Iran dataframe
Iran_df <- df %>%
  filter(geoId == "IR") %>%
  arrange(desc(dateRep))
