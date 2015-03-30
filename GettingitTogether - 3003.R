urlsDf <- teamlinks("http://www.bbc.co.uk/sport/football/teams/middlesbrough/results")
newDataFrame <- merge(df, urlsDf, by.x="url", by.y="matchlinks")


tempdf <- data.frame()

tempdf <- do.call("rbind", apply(epllinks,MARGIN=2,getmatchdata))
tempdf <- rbindlist(epllinks$matchlinks[1],use.names=FALSE,fill=FALSE)


epllinks <- leaguelinks(eplurl)
templinks <- epllinks[1:3,]


tempdf <- lapply(templinks$matchlinks,FUN=getmatchdata) %>%
    do.call(rbind,.) %>%
    makedata(.)



