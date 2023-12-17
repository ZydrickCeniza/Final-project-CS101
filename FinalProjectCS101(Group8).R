library(rvest)
library(httr)
library(dplyr) 
library(polite)

library(kableExtra)



polite::use_manners(save_as = 'polite_scrape.R')


url <- 'https://www.airlinequality.com/airline-reviews/airasia/'
session <- bow(url,
               user_agent = "Educational")


title <- character(0)


titles_list <- scrape(session) %>%
  html_nodes('h3.text_sub_header') %>% 
  html_text

titles_list_sub <- as.data.frame(titles_list[1:10])
colnames(titles_list_sub) <- "ranks"


split_df <- strsplit((titles_list_sub$ranks),"\r\n","reviews",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))

title<- data.frame(
  title= split_df)

title<-title[,c(-1,-2,-3)]
split_df <- strsplit((title),"(",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df
name<-as.data.frame(split_df[,1])
name
split_df <- strsplit((split_df$X2),")",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df
num1<-cbind(name,split_df)
num1

# Create a 2x3 array
xname<-array(2:30)
xone<-array(2:30)
xtwo<-array(2:30)
# Example for loop
for (i in 2:30) {
  url<-paste("https://www.airlinequality.com/airline-reviews/airasia/page/",i,"/", sep = "")
  url
  session <- bow(url,
                 user_agent = "Educational")
  
  
  title <- character(0)
  
  
  titles_list <- scrape(session) %>%
    html_nodes('h3.text_sub_header') %>% 
    html_text
  
  titles_list_sub <- as.data.frame(titles_list[1:10])
  colnames(titles_list_sub) <- "ranks"
  
  
  split_df <- strsplit((titles_list_sub$ranks),"\r\n","reviews",fixed = TRUE)
  split_df <- data.frame(do.call(rbind,split_df))
  
  title<- data.frame(
    title= split_df)
  title
  title<-title[,c(-1,-2,-3)]
  title
  split_df<- strsplit((title),"(",fixed = TRUE)
  split_df<- data.frame(do.call(rbind,split_df))
  split_df
  name<-as.data.frame(split_df[,1])
  name
  split_df<- strsplit((split_df$X2),")",fixed = TRUE)
  split_df<- data.frame(do.call(rbind,split_df))
  split_df
  xname[i]<-name
  xone[i]<-as.data.frame(split_df$X1)
  xtwo[i]<-as.data.frame(split_df$X2)
}
for (i in 2:30){
  df1<-data.frame(
    data=c(xone[i])
  ) 
  colnames(df1)<-"data"
  
  if(i==2){
    resc<-df1
  }
  else if(i>2){
    resc<-rbind(resc,df1)
  }
}

for (i in 2:30){
  df1<-data.frame(
    data=c(xname[i])
  ) 
  colnames(df1)<-"data"
  
  if(i==2){
    resn<-df1
  }
  else if(i>2){
    resn<-rbind(resn,df1)
  }
}

for (i in 2:30){
  df1<-data.frame(
    data=c(xtwo[i])
  ) 
  colnames(df1)<-"data"
  
  if(i==2){
    resd<-df1
  }
  else if(i>2){
    resd<-rbind(resd,df1)
  }
}
num2<-cbind(resn,resc,resd)
num2
colnames(num1)<-c("Name","Country","Date")
colnames(num2)<-c("Name","Country","Date")
part3<-rbind(as.data.frame(num1),as.data.frame(num2))
part3


