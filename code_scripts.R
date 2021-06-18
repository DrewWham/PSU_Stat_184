

submitCode5<-function(user_id,x){
  size<-5
  code<-c(1,1,0,1,0)
  sub_code<-as.numeric(strsplit(x,"")[[1]])
  percent<-sum(code==sub_code)/size
  out<-percent
  if (percent==1){out="jellyfish"}
  return(out)
}

submitCode256<-function(user_id,x){
  size<-256
  code_string<-"0111101010100000010111110011001011101001011001010000101000001111000000000010011001110001110110100010100110000011011010001101101101111111000000111111110011111011110100111011001011011000011100110011110010110100001000001010011000100001000111101101110110101000"
  code<-as.numeric(strsplit(code_string,"")[[1]])
  sub_code<-as.numeric(strsplit(x,"")[[1]])
  percent<-sum(code==sub_code)/size
  out<-percent
  if (percent==1){out="vanilla_latte"}
  return(out)
}
