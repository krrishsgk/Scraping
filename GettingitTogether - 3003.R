library(data.table)

tempdf <- data.frame()

tempdf <- do.call("rbind", apply(epllinks,MARGIN=2,getmatchdata))
tempdf <- rbindlist(epllinks$matchlinks[1],use.names=FALSE,fill=FALSE)


epllinks <- leaguelinks(eplurl)
templinks <- epllinks[1:3,]


finaldf <- lapply(epllinks$matchlinks,FUN=getmatchdata) %>%
    rbindlist(.) %>%
    makedata(.)


newDataFrame <- merge(epllinks, finaldf, by.x="matchlinks", by.y="url")
write.csv(newDataFrame, "BBCScrapeEpl.csv")

