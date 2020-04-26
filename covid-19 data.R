library(httr)
library(tidyverse)
library(flexdashboard)
library(DT)
library(tibbletime)
library(RCurl)
library(plotly)
library(readxl)
library(broman)

# updates date for data
url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time() - 12, "%Y-%m-%d"), ".xlsx", sep = "")

# manual method
##url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-2020-04-26.xlsx")

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
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows global_cases_plot to be interactive because of plotly
ggplotly(global_cases_plot)

# create plot showing global deaths
global_deaths_plot <- ggplot(cases_deaths_by_date_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows global_deaths_plot to be interactive because of plotly
ggplotly(global_deaths_plot)

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