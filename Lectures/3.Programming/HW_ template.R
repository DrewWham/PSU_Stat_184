library(data.table)
library(jsonlite)



# arguments



# function that will submit a given string and return the % matched
submitCode256<-function(user_id,x){
url <- paste0("https://dsdemo.vmhost.psu.edu/api/nlp/CodeBreak_256?user_id=",user_id,"&x=",x)
read_json(url)[[1]]
}


submitCode5<-function(user_id,x){
  url <- paste0("https://dsdemo.vmhost.psu.edu/api/nlp/CodeBreak_5?user_id=",user_id,"&x=",x)
  read_json(url)[[1]]
}

# your functions


########
##main##
########


# your main script


 





