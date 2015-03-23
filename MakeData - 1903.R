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

#is it a penalty?
data$ispen <- grepl("Penalty|penalty", data$livetext)


#primary Player
for(i in 1:nrow(data)){
    if(grepl("missed",data$livetext[i])==TRUE){
        data$primaryplayer[i] <- str_match(data$livetext[i], "Attempt missed. ([a-zA-Z0-9\ ]+)\\ ")[2]
    }
    else if(grepl("blocked",data$livetext[i])==TRUE){
        data$primaryplayer[i] <- str_match(data$livetext[i], "Attempt blocked. ([a-zA-Z0-9\ ]+)\\ ")[2]
    }
    else if(grepl("saved",data$livetext[i])==TRUE){
        data$primaryplayer[i] <- str_match(data$livetext[i], "Attempt saved. ([a-zA-Z0-9\ ]+)\\ ")[2]
    }
    
    else{
        data$primaryplayer[i] <- NA
    }
}


#Save or goal location
locations <- c("top right corner","bottom right corner","top left corner", "bottom left corner",
               "centre of the goal","top centre of the goal")

locationshorts <- c("TRC","BRC","TLC","BLC","C","TC")
for (i in 1:length(locations)) {
    data$goalposition[grepl(locations[i],data$livetext, perl=TRUE)] <- locationshorts[i]
}

#Shooting Foot
rightorleft <- c("header","right footed shot","left footed shot")
RorL <- c("H","R","L")
for (i in 1:length(rightorleft)) {
    data$foot[grepl(rightorleft[i],data$livetext, perl=TRUE)] <- RorL[i]
}

#Find out the primary team involved but doesn't make sense
#data$PrimaryTeam[grepl(".*\\((.*)\\).*",data$livetext)] <- gsub(".*\\((.*)\\).*", "\\1", data$livetext)

return(data)
}

#temp processing. delete later
match <- getmatchdata(league$matchlinks[12])
x<-grep(pattern="right footed shot",x=match$livetext)
match$livetext[x]

#Primary Player - not working
match$test[grepl("missed",match$livetext,perl=TRUE)] <- str_match(match$livetext, "Attempt missed. ([a-zA-Z0-9\ ]+)\\ ")[2]
primaryplayer <- str_match(match$livetext[5], "Attempt missed. ([a-zA-Z0-9\ ]+)\\ ")[2]



#checking shots data
which($eventType=="shot") %>% length
which(!is.na(data$shotposition)) %>% length


#Get shot position
#data$shotlocation <- NA
#indexes <- which(data$eventType=="shot") 
#data$shotlocation[indexes] <-gsub(".*from\\s*|is.*","", data$livetext[indexes]) %>%
#    str_trim
