#All the required functions have now been coded. Creating this code to call all the functions
#in this giant big function

#Run all the other functions before running this one as this calls all the other functions

#Submit the link that has the results of all the games to this function

getItTogether <- function(eplurl)
{
library(data.table)
library(dplyr)

epllinks <- leaguelinks(eplurl)

#Run the data.table package before using rbindlist
finaldf <- lapply(epllinks$matchlinks,FUN=getmatchdata) %>%
  rbindlist(.) %>%
  makedata(.)

#merging data with fixtures and score
newDataFrame <- merge(epllinks, finaldf, by.x="matchlinks", by.y="url")

#creating dataset for shots alone
shotsData <- filter(.data=newDataFrame,eventType=="shot")
return(shotsData)
}

#Trying it out
links <- "http://web.archive.org/web/20150726055602/http://www.bbc.com/sport/football/premier-league/results"

shots1415 <- getItTogether(links)

shotsNas <- filter(.data=shots1415,is.na(shots1415$shotposition))
