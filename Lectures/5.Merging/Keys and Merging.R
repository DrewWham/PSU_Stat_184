#load libraries
library(data.table)




#This reads in the flight data and stores it as an object called 'DT'
DT<-fread("../Data/Flights/2008.csv")
#This reads in the data about airports and stores it as an object called 'AP'
AP<-fread("../Data/Flights/airports.csv")




#calculate some aggregate stats 
Avg_DepDelay<-DT[,.(Avg_DepDelay=mean(DepDelay,na.rm=T)),by=Origin]
Avg_Dist<-DT[,.(Avg_Dist=mean(Distance,na.rm=T)),by=Origin]
Avg_TaxTime<-DT[,.(Avg_TaxTime=mean(TaxiOut,na.rm=T)),by=Origin]


# before showing prefered method:
merge_DT<-merge(DT,AP,by.x = "Origin",by.y="iata_code")

setnames(AP,"iata_code","Origin")

#merging with keys
#first set some keys
setkey(AP,Origin)
setkey(Avg_DepDelay, Origin)
setkey(Avg_Dist, Origin)
setkey(Avg_TaxTime, Origin)

#merge

Airport_stats<-merge(Avg_DepDelay,AP,all.x=T)
Airport_stats<-merge(Airport_stats,Avg_Dist,all.x=T)
Airport_stats<-merge(Airport_stats,Avg_TaxTime,all.x=T)

Airport_stats<-Airport_stats[,.(Origin,name,latitude_deg,longitude_deg,Avg_DepDelay,Avg_Dist,Avg_TaxTime)]

fwrite(Airport_stats,"../Data/Flights/Airport_stats.csv")
