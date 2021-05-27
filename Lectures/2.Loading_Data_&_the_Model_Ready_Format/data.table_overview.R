library(dplyr)
library(data.table)


#download.file(url="https://s3.amazonaws.com/stat.184.data/Flights/2008.csv",destfile='./Lectures/1.Review_of_Data_Wrangling/Data/2008.csv', method='curl')
#download.file(url="https://s3.amazonaws.com/stat.184.data/Flights/airports.csv",destfile='./Lectures/1.Review_of_Data_Wrangling/Data/airports.csv', method='curl')


# first major difference is how data is read into R
system.time(DF<-read.csv("./Lectures/Data/Flights/2008.csv"))
system.time(DT<-fread("./Lectures/Data/Flights/2008.csv"))
AP<-fread("./Data/airports.csv")

# notice the last line of the str for the DF and the DT
str(DF)
str(DT)

# The base syntax in data.table is DT[row,col, by]
system.time(Univ_Park_AP <- DT[Origin == "SCE"])

str(DT)

# notice that data.table made an index for you
system.time(Univ_Park_AP <- DT[Origin == "SCE"])

# you can tell it to make it an index
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
