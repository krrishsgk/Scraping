makedata <- function(data)
{
textMarkers <- c("Penalty conceded", "Substitution", "Dismissal", "Booking", "wins a free kick", "Offside","Corner", "Foul",
                 "Attempt|Goal!|hits the right post|hits the left post|hits the bar|Penalty saved!|Penalty missed!",
                 "Own Goal")


eventIDs <- c("penfoul","sub","red","yellow","free kick won", "offside","corner", "foul", "shot", "own goal")

#assign event type to each commentary event. 
for (i in 1:length(textMarkers)) {
    data$eventType[grepl(textMarkers[i],data$livetext, perl=TRUE)] <- eventIDs[i]
}

shottypes <- c("very close range","centre of the box","outside the box","a difficult angle on the right",
               "a difficult angle on the left","left side of the box","right side of the box",
               "right side of the six yard box","left side of the six yard box")

for (i in 1:length(shottypes)) {
    data$shotposition[grepl(shottypes[i],data$livetext, perl=TRUE)] <- shottypes[i]
}

#is it a goal?
data$isgoal <- grepl("Goal", data$livetext)


#Find out the primary team involved but doesn't make sense
#data$PrimaryTeam[grepl(".*\\((.*)\\).*",data$livetext)] <- gsub(".*\\((.*)\\).*", "\\1", data$livetext)

return(data)
}

#temp processing. delete later
data <- getmatchdata(df$matchlinks[34])
x<-grep(pattern="saved",x=data$livetext)
data$livetext[x]



#checking shots data
which(data$eventType=="shot") %>% length
which(!is.na(data$shotposition)) %>% length


very close range
centre of the box
outside the box
a difficult angle on the right
a difficult angle on the left
left side of the box
right side of the box
right side of the six yard box
left side of the six yard box

#Get shot position
#data$shotlocation <- NA
#indexes <- which(data$eventType=="shot") 
#data$shotlocation[indexes] <-gsub(".*from\\s*|is.*","", data$livetext[indexes]) %>%
#    str_trim
