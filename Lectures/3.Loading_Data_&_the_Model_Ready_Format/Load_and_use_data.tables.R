# ".csv" files are a common way to store data, we can load ".csv" files with the fread() function:
# first, you will need to download the flights data. Going to this address in a chrome browser
# will download the data. In other browsers you may need to "save as" then save as a .csv .

# https://s3.amazonaws.com/stat.184.data/Flights/2008.csv
# https://s3.amazonaws.com/stat.184.data/Flights/airports.csv

# you can also use this line of code which I have tested on macs but may have issues on Windows
source("../Lectures/Data/download_flights.R")

library(data.table)

# This reads in the flight data and stores it as an object called 'DT'
DT<-fread("../Data/Flights/2008.csv")
# This reads in the data about airports and stores it as an object called 'AP'
AP<-fread("../Data/Flights/airports.csv")
# sometimes data files are large and you might want to just load a subset to investigate
# use the 'nrows' argument to bring a few rows in

DT_subset<-fread("../Data/Flights/2008.csv",nrows=100)

# We can now look at the data with some useful functions

# the dim() function will show you the number of rows and the number of columns in a data_table
dim(DT)

# this is okay with a data_table but it is bad practice
DT

# this is the preferred way to look at the top of an object
head(DT)

# this is the preferred way to look at the bottom of an object
tail(DT)

# we learned about data types above, this is a useful way to inspect a data object and see column types
str(DT)

# we can write out data with the fwrite command
fwrite(DT_subset, "../Data/Flights/subset_2008.csv")


# Subsetting a data.table

# get only the rows from flights out of univerity park airport, subset with a logical statement

SCE<-DT[Origin == "SCE"]

# use a vector to subset all rows where a value is in the vector

WF<-DT[Origin %in% c('DCA','IAD','BWI')]

#or

WashAP<-c('DCA','IAD','BWI')

WF<-DT[Origin %in% WashAP]

# select only some of the columns in DT and return as a new data.table

delay_tab<-WF[,.(Origin,ArrDelay,DepDelay,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay)]

head(delay_tab)

# we can also sort

delay_tab<-delay_tab[order(DepDelay)]
# or
delay_tab<-delay_tab[order(-DepDelay)]


# notice that some flights have NA for all of their delay-type values even though they were delayed
# we can remove all of them by subsetting with a logical statement

delay_tab_no_NA<-delay_tab[!is.na(delay_tab$CarrierDelay)]

# get the average DepDelay

mean(delay_tab_no_NA$DepDelay)

# or

delay_tab_no_NA[,mean(DepDelay)]

# also this method will let you build a new data table, it is less useful when you are just getting a single value

delay_tab[,.(Avg_DepDelay=mean(DepDelay,na.rm=T))]

delay_tab[,.(Avg_ArrDelay=mean(ArrDelay,na.rm=T),Avg_DepDelay=mean(DepDelay,na.rm=T))]

#however, it is very useful once you start using the "by" operation

delay_tab[,.(Avg_ArrDelay=mean(ArrDelay,na.rm=T),Avg_DepDelay=mean(DepDelay,na.rm=T)), by=Origin]

# frequently you will want to count how many observations of comething are in a dataset, data.table
# provides a conveniant notation for that:

# total number of flights leaving each airport
DT[,.N,by=Origin]

#total number of flights between each airport
DT[,.N,by=c('Origin','Dest')]





