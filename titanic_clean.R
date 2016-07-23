#Loading in the neccessary libraries and loading in the csv file
library(tidyr)
library(dplyr)
library(dummies)
ship <- read.csv(file = "titanic3.xls - titanic3.csv")

#Replacing the missing values with S in the embarked Column
ship$embarked <- gsub("^$", "S", ship$embarked)

#Replacing the NA values to the mean age of the people on the Titanic
ship$age[is.na(ship$age)] <- 29.8800

#Next I am replacing the empty string of the boat column to NA
ship$boat <- gsub("^$", NA, ship$boat)