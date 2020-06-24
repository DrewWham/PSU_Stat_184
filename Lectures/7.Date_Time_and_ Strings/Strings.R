library(data.table)
library(stringr)
library(stringi)
library(ggplot2)


# https://cran.r-project.org/web/packages/stringi/stringi.pdf

#This reads in the flight data and stores it as an object called 'DT'
DT<-fread("../Data/BikeShare/Trips.csv")

#look at the data type for each coloumn
str(DT)


# use gsub on bikeno 
# https://www.cheatography.com/davechild/cheat-sheets/regular-expressions/

DT$bike_num<-gsub("[^0-9]", "", DT$bikeno) 
DT$bike_letter<-gsub("[0-9]", "", DT$bikeno) 

# solution using stringi

DT$bike_letter<- unlist(stri_extract_all_regex(DT$bikeno, "[A-Za-z]+"))

#using substring
DT$bike_num<-substring(DT$bikeno,2)

# using string split

test<-strsplit(DT$sdate,"T")
test<-matrix(unlist(strsplit(DT$sdate,"T")),ncol=2,byrow=T)

Time<-data.table(matrix(unlist(strsplit(DT$sdate,"T")),ncol=2,byrow=T))

# Find pattern match

sub_DT<-DT[grep("Wis",DT$sstation)]

# using stringi

sub_DT<-DT[stri_startswith_fixed(DT$sstation,"Wis")]
 

