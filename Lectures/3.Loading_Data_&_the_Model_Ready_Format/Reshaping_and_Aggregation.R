#load libraries
library(data.table)


#This reads in the flight data and stores it as an object called 'DT'
DT<-fread("../Data/Flights/2008.csv")
#This reads in the data about airports and stores it as an object called 'AP'
AP<-fread("../Data/Flights/airports.csv")

#Reshaping and aggregating are two of the most important functions you will use in data wrangling
#We will use two methods

#data.table has built in aggregation function
WF[,.(Avg_Delay=mean(DepDelay)),by=Origin]

#dcast offeres a larger set of reshaping options
Avg_Delay_tab<-dcast(WF,Origin ~ .,mean,value.var= c("DepDelay"))
#dcast allows you to define multiple groupings
Avg_Delay_tab<-dcast(WF,Origin ~ UniqueCarrier,mean,value.var= c("DepDelay"))

#this is the same information in tidy format
Avg_Delay_tab<-dcast(WF,Origin + UniqueCarrier~.,mean,value.var= c("DepDelay"))

#rename the '.' column
setnames(Avg_Delay_tab,".","Average_Delay")

fwrite(Avg_Delay_tab,"Avg_Delay_tab.csv")


# Practice questions: 

# 1) What was the average DepDelay for flights leaving 'SFO'?

# 2) How many flights originated out of the Charleston SC airport 'CHS'

# 3) How many unique airports did flights leaving the university park airport fly to?

# 4) Whats the average airtime for a flight between SFO and ATL?

# 5) Considering only the New York city area airports (John F. Kennedy, LaGuardia and Newark Liberty), which airport 
# has the largest average departure delay

# 6) Considering only the New York city area airports, which airport has the largest number of unique destinations?

# 7) Considering only the airports in this dataset with more than 1000 flights, which airport has the lowest average DepDelay?








