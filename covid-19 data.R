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

# create United States dataframe
US_df <- df %>%
  filter(geoId == "US") %>%
  arrange(desc(dateRep))

# create plot showing US cases
US_cases_plot <- ggplot(US_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in the US') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows US_cases_plot to be interactive because of plotly
ggplotly(US_cases_plot)

# create plot showing global deaths
US_deaths_plot <- ggplot(US_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in the US') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows US_deaths_plot to be interactive because of plotly
ggplotly(US_deaths_plot)

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

# create plot showing Italy cases
Italy_cases_plot <- ggplot(Italy_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in Italy') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows Italy_cases_plot to be interactive because of plotly
ggplotly(Italy_cases_plot)

# create plot showing Italy deaths
Italy_deaths_plot <- ggplot(Italy_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in Italy') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows Italy_deaths_plot to be interactive because of plotly
ggplotly(Italy_deaths_plot)

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

# create plot showing Spain cases
Spain_cases_plot <- ggplot(Spain_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in Spain') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows Spain_cases_plot to be interactive because of plotly
ggplotly(Spain_cases_plot)

# create plot showing Spain deaths
Spain_deaths_plot <- ggplot(Spain_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in Spain') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows Spain_deaths_plot to be interactive because of plotly
ggplotly(Spain_deaths_plot)

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

# create plot showing Germany cases
Germany_cases_plot <- ggplot(Germany_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in Germany') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows Germany_cases_plot to be interactive because of plotly
ggplotly(Germany_cases_plot)

# create plot showing Germany deaths
Germany_deaths_plot <- ggplot(Germany_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in Germany') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows Germany_deaths_plot to be interactive because of plotly
ggplotly(Germany_deaths_plot)

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

# create plot showing China cases
China_cases_plot <- ggplot(China_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in China') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows China_cases_plot to be interactive because of plotly
ggplotly(China_cases_plot)

# create plot showing China deaths
China_deaths_plot <- ggplot(China_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in China') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows China_deaths_plot to be interactive because of plotly
ggplotly(China_deaths_plot)

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

# create plot showing France cases
France_cases_plot <- ggplot(France_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in France') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows France_cases_plot to be interactive because of plotly
ggplotly(France_cases_plot)

# create plot showing France deaths
France_deaths_plot <- ggplot(France_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in France') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows France_deaths_plot to be interactive because of plotly
ggplotly(France_deaths_plot)

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

# create plot showing Iran cases
Iran_cases_plot <- ggplot(Iran_df, aes(x = dateRep, y = cases)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Cases in Iran') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Cases")

# allows Iran_cases_plot to be interactive because of plotly
ggplotly(Iran_cases_plot)

# create plot showing Iran deaths
Iran_deaths_plot <- ggplot(Iran_df, aes(x = dateRep, y = deaths)) +
  geom_line(color = "#2196f3") +
  geom_point(color = "#2196f3", size = .75) +
  ggtitle('Daily Covid-19 Deaths in Iran') +
  theme_bw() +
  theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
  labs(x = "Date", y = "Deaths")

# allows Iran_deaths_plot to be interactive because of plotly
ggplotly(Iran_deaths_plot)

# calculate total cases in Iran
Iran_total_cases <- Iran_df %>%
  summarise(cases = sum(cases))

# calculate total deaths in Iran
Iran_total_deaths <- Iran_df %>%
  summarise(deaths = sum(deaths))