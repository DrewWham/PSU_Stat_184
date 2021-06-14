

submitCode5<-function(user_id,x){
  set.seed(4)
  size<-5
  code<-sample(c(1,0),size,replace=T)
  sub_code<-as.numeric(strsplit(x,"")[[1]])
  percent<-sum(code==sub_code)/size
  out<-percent
  if (percent==1){out="jellyfish"}
  return(out)
}

submitCode256<-function(user_id,x){
  set.seed(4)
  size<-256
  code<-sample(c(1,0),size,replace=T)
  sub_code<-as.numeric(strsplit(x,"")[[1]])
  percent<-sum(code==sub_code)/size
  out<-percent
  if (percent==1){out="vanilla_latte"}
  return(out)
}