library(httr)
library(tidyverse)
library(flexdashboard)
library(DT)
library(tibbletime)
library(RCurl)

# not using this until issue is fixed
##url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time() - 12, "%Y-%m-%d"), ".xlsx", sep = "")

# manually change this url to update
url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-2020-04-04.xlsx")

# download the dataset to a local temporary file
GET(url, write_disk(tf <- tempfile(fileext = ".xlsx")))

# read the Dataset sheet into “R”
df <- read_excel(tf)

# create cases and deaths by date dataframe
cases_deaths_by_date_df <- df %>%
  group_by(dateRep) %>%
  summarise(cases = sum(cases),deaths = sum(deaths))

# create plot showing global cases
global_cases_plot <- ggplot(cases_deaths_by_date_df, aes(x = dateRep, y = cases)) +
  geom_line() +
  ggtitle('Daily Covid-19 Cases (Since 2019-12-31)')

# create plot showing global deaths
global_deaths_plot <- ggplot(cases_deaths_by_date_df, aes(x = dateRep, y = deaths)) +
  geom_line() +
  ggtitle('Daily Covid-19 Deaths (Since 2019-12-31)')

# create case totals by country dataframe
cases_by_country_df <- df %>%
  group_by(countriesAndTerritories) %>%
  summarise(cases = sum(cases)) %>%
  arrange(desc(cases))

# create top 5 case totals by country dataframe
cases_by_country_top5_df <- cases_by_country_df %>%
  head(5) %>%
  arrange(desc(cases))

# create death totals by country dataframe
deaths_by_country_df <- df %>%
  group_by(countriesAndTerritories) %>%
  summarise(deaths = sum(deaths)) %>%
  arrange(desc(deaths))

# create top 5 death totals by country dataframe
deaths_by_country_top5_df <- deaths_by_country_df %>%
  head(5) %>%
  arrange(desc(deaths))

# create deaths and cases by country dataframe
deaths_cases_by_country_df <- df %>%
  group_by(countriesAndTerritories) %>%
  summarize(cases = sum(cases),deaths = sum(deaths)) %>%
  arrange(desc(cases))

# create United States dataframe
US_df <- df %>%
  filter(geoId == "US") %>%
  arrange(desc(dateRep))

# calculate total cases in US
US_total_cases <- US_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in US
US_total_deaths <- US_df %>%
  summarise(deaths = sum(deaths))

# create Italy dataframe
Italy_df <- df %>%
  filter(geoId == "IT") %>%
  arrange(desc(dateRep))

# calculate total cases in Italy
Italy_total_cases <- Italy_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in Italy
Italy_total_deaths <- Italy_df %>%
  summarise(deaths = sum(deaths))

# create Spain dataframe
Spain_df <- df %>%
  filter(geoId == "ES") %>%
  arrange(desc(dateRep))

# calculate total cases in Spain
Spain_total_cases <- Spain_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in Spain
Spain_total_deaths <- Spain_df %>%
  summarise(deaths = sum(deaths))

# create Germany dataframe
Germany_df <- df %>%
  filter(geoId == "DE") %>%
  arrange(desc(dateRep))

# calculate total cases in Germany
Germany_total_cases <- Germany_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in Germany
Germany_total_deaths <- Germany_df %>%
  summarise(deaths = sum(deaths))

# create China dataframe
China_df <- df %>%
  filter(geoId == "CN") %>%
  arrange(desc(dateRep))

# calculate total cases in China
China_total_cases <- China_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in China
China_total_deaths <- China_df %>%
  summarise(deaths = sum(deaths))

# create France dataframe
France_df <- df %>%
  filter(geoId == "FR") %>%
  arrange(desc(dateRep))

# calculate total cases in France
France_total_cases <- France_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in France
France_total_deaths <- France_df %>%
  summarise(deaths = sum(deaths))

# create Iran dataframe
Iran_df <- df %>%
  filter(geoId == "IR") %>%
  arrange(desc(dateRep))

# calculate total cases in Iran
Iran_total_cases <- Iran_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in Iran
Iran_total_deaths <- Iran_df %>%
  summarise(deaths = sum(deaths))