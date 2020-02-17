
library(leaflet)
library(RPostgreSQL)
library(shiny)
library(shinyWidgets)
library(tidyverse)

##### connect database and generate data

# welcome message when open
cat('Welcome to FIFA 2019!')

## connect to postgresql server
con <- dbConnect(drv = dbDriver('PostgreSQL'), 
                 dbname = 'sql_fifa',
                 host = 's19db.apan5310.com', port = 50203,
                 user = 'postgres', password = 'rjxklxet')

# run query to generate dataframe for ballparks
#p <- dbGetQuery(con, 
#                "SELECT park, team_name, lat, lng,
#                CASE WHEN lg_id = 'AL' THEN 'red' ELSE 'blue' END AS color, 
#                CASE WHEN lg_id = 'AL' THEN 'star' ELSE 'star-empty' END AS icon
#                FROM teams 
#                WHERE year_id = 2018;")

# execute upon close
onStop(function() 
{
  dbDisconnect(con)
  rm(list = ls())
  cat('Thank you!')
}
)

