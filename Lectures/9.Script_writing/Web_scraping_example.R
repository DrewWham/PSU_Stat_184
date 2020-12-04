library(rvest)
library(XML)
library(data.table)



# this function is useful for grabing all links on a page
links <- function(URL) 
{
  getLinks <- function() {
    links <- character()
    list(a = function(node, ...) {
      links <<- c(links, xmlGetAttr(node, "href"))
      node
    },
    links = function() links)
  }
  h1 <- getLinks()
  htmlTreeParse(URL, handlers = h1)
  h1$links()
}

# this function gets a single value from a page (player name in this case)
get_name<-function(url){
  page<-read_html(url)
  node<-html_nodes(page,".player-name")
  player_name<-html_text(node)
  player_name
}



# Set start web url
NFL <- read_html("https://www.nfl.com/stats/player-stats/")
# get all the players names

Player_lst<-NULL
current_page_links<-links(NFL)
next_page_link<-current_page_links[grep("/stats/player-stats/category",current_page_links)]
next_page_link<-next_page_link[grep("?aftercursor",next_page_link)]
next_page_link<-gsub("/stats/player-stats/","",next_page_link)

while (length(next_page_link)>0){

player_link_lst<-current_page_links[grep("/players/",current_page_links)]
player_link_lst<-player_link_lst[-grep("www.nfl",player_link_lst)]
Player_lst<-c(Player_lst,player_link_lst)

current_page<-read_html(paste0("https://www.nfl.com/stats/player-stats/",next_page_link))
current_page_links<-links(current_page)

next_page_link<-current_page_links[grep("/stats/player-stats/category",current_page_links)]
next_page_link<-next_page_link[grep("?aftercursor",next_page_link)]
next_page_link<-gsub("/stats/player-stats/","",next_page_link)
}








# make a for loop to get all the players
data<-NULL
for (i in 1:length(Player_lst)){
  # go to each player page
  goto<-paste0("http://www.nfl.com",Player_lst[i],"stats/")
  # get the tables on the page
  
  tables<-html_table(read_html(goto),fill = TRUE)
  # figure out which table is the one we want
  target_tab<-tables[[1]]
  # get the table we want
  DT<-data.table(target_tab)
  
  DT$player_link<-Player_lst[i]

  data<-rbind(data,DT)
  
  message(Player_lst[i])
}

fwrite(data,"NFL_QB_stats.csv")
