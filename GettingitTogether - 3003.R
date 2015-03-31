library(data.table)

tempdf <- data.frame()

tempdf <- do.call("rbind", apply(epllinks,MARGIN=2,getmatchdata))
tempdf <- rbindlist(epllinks$matchlinks[1],use.names=FALSE,fill=FALSE)


epllinks <- leaguelinks(eplurl)
templinks <- epllinks[1:3,]


finaldf <- lapply(epllinks$matchlinks,FUN=getmatchdata) %>%
    rbindlist(.) %>%
    makedata(.)

#merging data with fixtures and score
newDataFrame <- merge(epllinks, finaldf, by.x="matchlinks", by.y="url")

#creating dataset for shots alone
shotsData <- filter(.data=newDataFrame,eventType=="shot")
shotsNas <- filter(.data=shotsData,is.na(shotsData$shotposition))

write.csv(newDataFrame, "BBCScrapeEpl.csv")

#Summarising
Footcuracy <- group_by(x=newDataFrame,primaryplayer,foot) %>%
    summarise(.,count(foot))

