library("DBI")
library("RMySQL")
con = dbConnect(RMySQL::MySQL(), user="root", host="localhost", password="", dbname="Nycflights", port=3306);dbListTables(con)

#--Livrables attendus

library(tidyverse)
library(lubridate) 

# Chargement des fichiers RDA:
load("C:/Users/x/Documents/R/Nycflights-db/Rda/flights.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/airlines.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/airports.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/weather.rda")
load("C:/Users/x/Documents/R/Nycflights-db/Rda/planes.rda")


library(readr)

write_csv(flights, "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/flights.csv")
write_csv(airports, "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/airports.csv")
write_csv(airlines, "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/airlines.csv")
write_csv(planes,  "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/planes.csv")
write_csv(weather,  "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/weather.csv")

apply(is.na(weather), 2, sum)
apply(is.na(planes), 2, sum)
apply(is.na(flights), 2, sum)


planes<-nycflights13::planes 
planes1<- factor(planes$type)
nchar(planes$type)
rm(planes1) #--README
planes$type <- factor(planes$type)
planes$manufacturer<- factor(planes$manufacturer)
table(planes$type)
plot(planes$type) 
plot(planes$model)
plot(planes$year)
plot(planes$year,planes$seats)
plot(planes$year,planes$manufacturer)
plot(planes$type,planes$manufacturer)


#--Data Wrangling : Se familiariser avec les données

max(nchar(airlines$name)) #--Pour trouver le nom le plus long dans airlines
max(weather$temp, na.rm = T)
max(nchar(sub('^.', '', airports$lon)))
max(nchar(sub('.*\\.', '', airports$lon)))

weather$time_hour <- as.character(weather$time_hour) #--la commande pour changer le type de time_hour à caractère

# OBTENIR LA PARTIE ENTIERE D'UN NOMBRE :
airports$lon[1]
[1] -80.61958

sub("\\.(.*)", "", airports$lon[1])
[1] "-80"

nchar(sub("\\.(.*)", "", airports$lon[1]))
[1] 3

max(nchar(sub("\\.(.*)", "", airports$lon)))
[1] 4


# OBTENIR LE NOMBRE DE CHIFFRES APRES LA DECIMALE :
airports$lon[1]
[1] -80.61958

sub('.*\\.', '', airports$lon[1])
[1] "6195833"

nchar(sub('.*\\.', '', airports$lon[1]))
[1] 7

max(nchar(sub('.*\\.', '', airports$lon)))
[1] 12