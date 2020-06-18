library(dplyr)
library(data.table)

# Additional reading
# https://rdatatable.gitlab.io/data.table/articles/datatable-secondary-indices-and-auto-indexing.html

# first major difference is how data is read into R
system.time(DF<-read.csv("../Data/Flights/2008.csv"))
system.time(DT<-fread("../Data/Flights/2008.csv"))
AP<-fread("./Data/airports.csv")

# notice the last line of the str for the DF and the DT
str(DF)
str(DT)

# The base syntax in data.table is DT[row,col, by]
system.time(Univ_Park_AP <- DT[Origin == "SCE"])

str(DT)

# notice that data.table made an index for you
system.time(Univ_Park_AP <- DT[Origin == "SCE"])

# you can tell it to make it a key
setkey(DT,Origin)

# notice the order is now changed
str(DT)

# your searches are now very fast
system.time(Univ_Park_AP <- DT[Origin == "SCE"])

# count things
DT[,.N,by=Origin]

# aggrigate over a group

DT[,.(mean_depdelay=mean(DepDelay,na.rm=T)),by=Origin]

# sort and chain

DT[,.(mean_depdelay=mean(DepDelay,na.rm=T)),by=Origin][order(-mean_depdelay)]

# scale up and apply a function to multiple columns

Avg_delay_tab<-dcast(DT,Origin + UniqueCarrier~.,mean,na.rm=T,value.var= c("DepDelay","ArrDelay","CarrierDelay","WeatherDelay","NASDelay","SecurityDelay","LateAircraftDelay"))

# go from wide to long format

m_Avg_delay_tab<-melt(Avg_delay_tab,id=c("Origin","UniqueCarrier"))


str(AP)
str(DT)

setnames(AP,"iata_code","Origin")
AP$Origin<-as.character(AP$Origin)
DF$Origin<-as.character(DF$Origin)
