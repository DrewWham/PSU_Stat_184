library(data.table)




# arguments

user_id<-

# function that will submit a given string and return the % matched
submitCode256<-function(user_id,x){
  set.seed(4)
  size<-256
  code<-sample(c(1,0),size,replace=T)
  sub_code<-as.numeric(strsplit(x,"")[[1]])
  percent<-sum(code==sub_code)/size
  out<-percent
  if (percent==1){out="jellyfish"}
  return(out)
}


submitCode5<-function(user_id,x){
  set.seed(4)
  size<-256
  code<-sample(c(1,0),size,replace=T)
  sub_code<-as.numeric(strsplit(x,"")[[1]])
  percent<-sum(code==sub_code)/size
  out<-percent
  if (percent==1){out="jellyfish"}
  return(out)
}

# your functions


########
##main##
########


# your main script




