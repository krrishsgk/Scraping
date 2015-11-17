library(data.table)
library(dplyr)

link1314 <- "http://web.archive.org/web/20140704090053/http://www.bbc.com/sport/football/premier-league/results"
tempdf <- data.frame()

tempdf <- do.call("rbind", apply(epllinks,MARGIN=2,getmatchdata))
tempdf <- rbindlist(epllinks$matchlinks[1],use.names=FALSE,fill=FALSE)


epllinks <- leaguelinks(link1314)
epllinks <- epllinks[1:320,]
#subsetting epllinks to experiment
templinks <- epllinks[1:190,]

#Run the data.table package before using rbindlist
shots1314 <- lapply(epllinks$matchlinks,FUN=getmatchdata)
shots1314 <- rbindlist(shots1314)
shots1314 <- makedata(shots1314)
#merging data with fixtures and score
shots1314 <- merge(epllinks, shots1314, by.x="matchlinks", by.y="url")

#creating dataset for shots alone
shots1314 <- filter(shots1314,eventType=="shot")

shotsNas <- filter(.data=shotsData,is.na(shotsData$shotposition))

write.csv(shots1314, "shots1314.csv")

#Summarising
shotPlaces <- group_by(x=shotsData, shotposition) %>%
    summarize(.,count=n())

link1415 <- "http://web.archive.org/web/20150531035857/http://www.bbc.com/sport/football/premier-league/results"
shots1415 <- getItTogether(link1415)
write.csv(shots1415, "shots1415.csv")
