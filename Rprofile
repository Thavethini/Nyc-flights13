cat("*** Chargement de mon .Rprofile Nycflights-db ***\n\n") 

# Chargement des packages :
if (require(tidyverse) == FALSE){
	utils::install.packages("tidyverse")
}
library(tidyverse)

if (require(lubridate) == FALSE){
	utils::install.packages("lubridate")
}
library(lubridate)

if(require(shiny) == FALSE){
	utils::install.packages("shiny")
}
library(shiny)

if (require(DBI) == FALSE){
	utils::install.packages("DBI")
}
library(DBI)

if (require(dbplyr) == FALSE){
	utils::install.packages("dbplyr")
}
library(dbplyr)

#flights_new <- nycflights13::flights
# airlines_new <- nycflights13::airlines
# airports_new <- nycflights13::airports
# weather_new <- nycflights13::weather
# planes_new <- nycflights13::planes

# Chargement des fichiers RDA:
load("C:/Users/x/Documents/R/Nycflights-db/Rda/flights.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/airlines.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/airports.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/weather.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/planes.rda")

## Rappel de certains raccourcis :
cat("Raccourci pour le pipe : CTRL + SHIFT + M\n")
cat("Pour afficher tous les raccourcis : ALT + SHIFT + K")
cat("\n \n")
cat ("*** Fin de chargement de mon .Rprofile.***\n \n")

#FIN .Rprofile
