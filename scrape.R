#rvest, xml2, tidyverse
library(rvest)
#kworb scrape
Spotifychart<-read_html("http://kworb.net/spotify/country/us_weekly_totals.html")
Spotifychart
#select nodes 
?html_nodes
#using selectorgadget for html nodes
artist<-Spotifychart%>%html_nodes(".mp a:nth-child(1)")%>%html_text
title<-Spotifychart%>%html_nodes("a+ a")%>%html_text
totalstreams<-Spotifychart%>%html_nodes(".mini~ td+ td")%>%html_text(trim = TRUE)
totalweeks<-Spotifychart%>%html_nodes(".mp+ td")%>%html_text

#turn into table
Spotify_dataset<-data.frame(artist,title,totalstreams,totalweeks, stringsAsFactors = FALSE)
Spotify_dataset


#Add rank column 
Spotify_dataset <- tibble::rowid_to_column(Spotify_dataset, "Rank")
Rank <- c(Spotify_dataset$Rank)
Rank <- as.numeric(as.integer(Rank))



#make variables numeric (DESTRING!!!!)
destring(totalweeks)
totalweeks <- as.numeric(as.character(totalweeks))

#workin on this 
destring(totalstreams)
totalstreams <-as.numeric(as.character(totalstreams))
destring(totalstreams)
totalstreams <-as.integer(as.character(totalstreams))




#sample dataframe to work in 
small_spotify <-Spotify_dataset[1:100,]

