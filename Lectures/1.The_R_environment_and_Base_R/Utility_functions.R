
paste("Hello","world",sep=" ")

words<-c("Hello","world")

paste(words,sep=" ")

paste(words,collapse = " ")

hello<-"Hello"

names_vec<-c("Drew","Paul","Sandy","Erica")

paste(hello,names_vec,sep=" ")

paste0(hello,names_vec)

paste0(hello," ",names_vec)

num_series<-1:10

num_series2<-seq(from=0,by=10,to=100)

hello_10<-rep("Hello",10)

rnorm(10,1,1)

sample(num_series,15)

rand_samp<-sample(num_series,15,replace = T)

max(rand_samp)
min(rand_samp)

length(rand_samp)

length(unique(rand_samp))

sum(2,5)

2+5

sum(2,5,7)

a<-c(2,1,0)

b<-c(4,3,8)

sum(a,b)

a+b

d<-c(5,8,5,NA,7)

sum(d,na.rm=T)

