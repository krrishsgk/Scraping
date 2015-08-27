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

shottypes <- c("free kick","Penalty|penalty","very close range","centre of the box","outside the box","a difficult angle on the right",
               "a difficult angle on the left","left side of the box","right side of the box",
               "right side of the six yard box","left side of the six yard box",
               "from a difficult angle and long range on the right",
               "from a difficult angle and long range on the left", "from more than 35 yards",
               "long range on the left","long range on the right",
               "from more than 40 yards on the right wing","from more than 40 yards on the left wing")

shotForms <- c("FreeKick","pen","CloseRange","CBox","OBox","DiffAngR","DiffAngL","LSBox","RSBox","RS6Box","LS6Box","DiffAngLongR",
               "DiffAngLongL","35YardsPlus","LongL","LongR","40PlusR","40PlusL")


for (i in 1:length(shottypes)) {
    data$shotposition[grepl(shottypes[i],data$livetext, perl=TRUE)] <- shotForms[i]
    }

#is it a goal?
data$isgoal <- grepl("Goal", data$livetext)

#is it a penalty?
data$ispen <- grepl("Penalty|penalty", data$livetext)


#primary Player
#Splits the line by fullstops. Takes the second entry, trims leading whitespace, and takes the values
#before '('
#If ball hits post or bar, the entry is different. Hence accounting for that. Have to take 1st entry
for (i in 1:nrow(data)) {
  if(grepl("hits the right post|hits the left post|hits the bar", data$livetext[i]))
  {
    data$primaryplayer[i] <- strsplit(data$livetext[i],'.',fixed=TRUE)[[1]][1]
  }
  else
  {
    data$primaryplayer[i] <- strsplit(data$livetext[i],'.',fixed=TRUE)[[1]][2]
  }
  data$primaryplayer[i] <- sub("^\\s+", "", data$primaryplayer[i]) 
  data$primaryplayer[i] <- strsplit(as.character(data$primaryplayer[i]),' (',fixed=TRUE)[[1]][1]
}

#Assisting player
#Splits sentence by period '.', and takes 3rd part. If type of assist is present (if sentence has
#'with', then take the name after 'by' and before 'with'. If not, take the name that follows 'by'.)
#If ball hits post or bar, the entry is different. Hence accounting for that. Have to take 2nd part
for (i in 1:nrow(data)) {
  if(grepl("hits the right post|hits the left post|hits the bar", data$livetext[i]))
  {
    data$assistplayer[i] <- strsplit(data$livetext[i],'.',fixed=TRUE)[[1]][2]
  }
  else
  {
    data$assistplayer[i] <- strsplit(data$livetext[i],'.',fixed=TRUE)[[1]][3]
  }
  
  if(grepl("with", x = data$assistplayer[i])) {
    data$assistplayer[i] <- str_match(data$assistplayer[i], paste("by ", '(.+)', " with", sep=''))[,2]    
  }
  else{
    data$assistplayer[i] <- str_match(data$assistplayer[i], paste("by ", '(.+)', sep=''))[,1] %>%
    sub("by ", "",.)
  }
}
  
  

#team the event maker belongs to. Takes values between brackets
data$eventteam <- sub("\\).*", "", sub(".*\\(", "", data$livetext)) 

#Save or goal location
locations <- c("top right corner","bottom right corner","top left corner", "bottom left corner",
               "centre of the goal","top centre of the goal","left post", "right post", "bar")

locationshorts <- c("TRC","BRC","TLC","BLC","C","TC", "LPost", "RPost", "Bar")
for (i in 1:length(locations)) {
    data$goalposition[grepl(locations[i],data$livetext, perl=TRUE)] <- locationshorts[i]
}

#Shooting Foot
rightorleft <- c("header","right footed shot","left footed shot")
RorL <- c("H","R","L")
for (i in 1:length(rightorleft)) {
    data$foot[grepl(rightorleft[i],data$livetext, perl=TRUE)] <- RorL[i]
}


return(data)
}

