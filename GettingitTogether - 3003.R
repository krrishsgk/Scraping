library(data.table)
library(dplyr)

eplurl <- "http://web.archive.org/web/20140704090053/http://www.bbc.com/sport/football/premier-league/results"
tempdf <- data.frame()

tempdf <- do.call("rbind", apply(epllinks,MARGIN=2,getmatchdata))
tempdf <- rbindlist(epllinks$matchlinks[1],use.names=FALSE,fill=FALSE)


epllinks <- leaguelinks(link1314)
epllinks <- epllinks[1:320,]
#subsetting epllinks to experiment
<<<<<<< HEAD
templinks <- epllinks[1:190,]

#Run the data.table package before using rbindlist
finaldf <- lapply(templinks$matchlinks,FUN=getmatchdata) 


%>%
=======
templinks <- epllinks[3,]

#Run the data.table package before using rbindlist
shots1314 <- lapply(templinks$matchlinks,FUN=getmatchdata) %>%
>>>>>>> origin/master
    rbindlist(.) %>%
    makedata(.)
#merging data with fixtures and score
shots1314 <- merge(epllinks, shots1314, by.x="matchlinks", by.y="url")

#creating dataset for shots alone
shotsData <- filter(.data=newDataFrame,eventType=="shot")

shotsNas <- filter(.data=shotsData,is.na(shotsData$shotposition))

write.csv(newDataFrame, "BBCScrapeEpl.csv")

#Summarising
shotPlaces <- group_by(x=shotsData, shotposition) %>%
    summarize(.,count=n())
