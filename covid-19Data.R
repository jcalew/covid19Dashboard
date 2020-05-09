library(httr)
library(tidyverse)
library(flexdashboard)
library(DT)
library(tibbletime)
library(RCurl)
library(plotly)
library(readxl)
library(broman)
library(shiny)

# updates date for data
url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time() - 12, "%Y-%m-%d"), ".xlsx", sep = "")

# manual method
##url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-2020-04-26.xlsx")

# download the dataset to a local temporary file
GET(url, write_disk(tf <- tempfile(fileext = ".xlsx")))

# read the Dataset sheet into “R”
df <- read_excel(tf)

# create cases and deaths by date dataframe
casesDeathsByDateDF <- df %>%
  group_by(dateRep) %>%
  summarise(cases = sum(cases),deaths = sum(deaths))

# create plot showing global cases wrapped with plotly to be interactive
globalCasesPlotly <- ggplotly(globalCasesPlot <- ggplot(casesDeathsByDateDF, aes(x = dateRep, y = cases)) +
                                geom_line(color = "#2196f3") +
                                geom_point(color = "#2196f3", size = .75) +
                                ggtitle('Daily Covid-19 Cases') +
                                theme_bw() +
                                theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
                                labs(x = "Date", y = "Cases"))

# create plot showing global deaths wrapped with plotly to be interactive
globalDeathsPlotly <- ggplotly(globalDeathsPlot <- ggplot(casesDeathsByDateDF, aes(x = dateRep, y = deaths)) +
                                 geom_line(color = "#2196f3") +
                                 geom_point(color = "#2196f3", size = .75) +
                                 ggtitle('Daily Covid-19 Deaths') +
                                 theme_bw() +
                                 theme(plot.title = element_text(size = 15,color = "#666666",face="bold")) +
                                 labs(x = "Date", y = "Deaths"))

# create case totals by country dataframe
casesByCountryDF <- df %>%
  group_by(countriesAndTerritories) %>%
  summarise(cases = sum(cases)) %>%
  arrange(desc(cases))

# create death totals by country dataframe
deathsByCountryDF <- df %>%
  group_by(countriesAndTerritories) %>%
  summarise(deaths = sum(deaths)) %>%
  arrange(desc(deaths))

# create deaths and cases by country dataframe
deathsCasesByCountryDF <- df %>%
  group_by(countriesAndTerritories) %>%
  summarize(cases = sum(cases),deaths = sum(deaths)) %>%
  arrange(desc(cases))
