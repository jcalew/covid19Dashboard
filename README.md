# Covid-19 Tracker
The Covid-19 Tracker is a simple dashboard that keeps track of Covid-19 confirmed cases, deaths, and trends using data from the European Centre for Disease Prevention and Control.

## Motivation
I wanted to get more practice working with data and building dashboards. This dashboard is something that I use to stay informed on the current pandemic.

## Libraries used
```
library(httr)
library(tidyverse)
library(flexdashboard)
library(DT)
library(tibbletime)
library(RCurl)
library(plotly)
```
## Current Status
Due to a couple of minor issues, the dashboard isn't live yet. I have included a screenshot below of what the home page currently looks like.

## Screenshot
![Dashboard Screenshot](/Users/cw/Desktop/Covid-19TrackerScreenshot.png)

### Thanks to
* [flexdashboard](https://github.com/rstudio/flexdashboard) - built using flexdashboard
* [ecdc](https://www.ecdc.europa.eu/en) - data source