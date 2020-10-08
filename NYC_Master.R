#################################################################################
##### RideSharing and USS: Data Import: NYC: Master
##### 10/8/2020
##### Description: Note that this file will need to be adjusted when new data is 
#####              posted to the landing website
#################################################################################

#################################################################################
##### RideSharing and USS: Data Import: NYC: Master
##### 28 Aug 2019
##### Description: Note that this file will need to be adjusted when new data is 
#####              posted to the landing website
#################################################################################

##### Filenames and Main Nomenclature
file_working    <- "C:\\Users\\cultice.7\\Dropbox"
file_main       <- paste0(file_working, "\\Work\\RideSharingUrbanSpatialStructure")
file_NYC        <- paste0(file_main, "\\Data\\NYC")
file_data       <- paste0(file_main, "\\Data\\PropertyTransactions\\NYC")
file_scripts    <- paste0(file_main, "\\Scripts")
keep_paths      <- c("file_working", "file_data", "file_scripts", "file_main", "general_scripts",
                     "file_NYC")

##### Load/Install Packages
libraries <-    c("here", "readxl", "tidytext", "stringdist", "rgeos", "rgdal", "raster",
                  "terra", "sf", "broom", "foreign", "Hmisc", "tidyverse", "data.table", 
                  "ggrepel", "rvest", "lubridate", "DBI", "odbc", "stargazer", "geojsonsf", 
                  "jsonlite", "httr", "sandwich", "lmtest", "McSpatial", "magick", "pryr")
pacman::p_load(char = libraries)

##### 
