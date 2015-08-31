#Trying out all the summarising and group bys

#Merging the shot datasets
shots1314 <- read.csv("shots1314.csv")
shots1314 <- shots1314[,-1]
shots1315 <- rbind(shots1314, shots1415)

#Summarising
library(data.table)
library(dplyr)

#Checking the data for cleanliness
temp <- grep("Assisted", shots1415$primaryplayer, perl = TRUE)
dump <- shots1315[temp,]

#Grouping by player, shot location, and foot
byPlayer <- group_by(shots1315, primaryplayer, shotposition, foot)
byPlayer <-summarise(byPlayer, shots = n())

#Filtering for on target shots
SoT <- filter(shots1315, goalposition != "NA")
SoT <- group_by(SoT, primaryplayer,  shotposition, foot)
SoT <- summarise(SoT, shots = n())
SoT <- rename(.data = SoT, onTarget = shots)

tempdata <- merge(byPlayer, SoT, by = c("primaryplayer", "shotposition","foot"), all.x = TRUE)


#Filtering for goals
goals <- filter(shots1315, isgoal == TRUE)
goals <- group_by(goals, primaryplayer, shotposition, foot)
goals <- summarise(goals, shots = n())
goals <- rename(.data = goals, goals = shots)

finaldataset <- merge(tempdata, goals, by = c("primaryplayer", "shotposition","foot"), all.x = TRUE)

#Creating Ratios
finaldataset <- mutate(finaldataset, ShootingAcc = (onTarget/shots)*100, Conversion = (goals/onTarget)*100)

#For players only
#Grouping shots
onlyPlayer <-  group_by(shots1315, primaryplayer)
onlyPlayer <- summarise(onlyPlayer, shots = n())

playerSoT <- filter(shots1315, goalposition != "NA")
playerSoT <- group_by(playerSoT, primaryplayer)
playerSoT <- summarise(playerSoT, shots = n())
playerSoT <- rename(.data = playerSoT, onTarget = shots)

playertempdata <- merge(onlyPlayer, playerSoT, by = c("primaryplayer"), all.x = TRUE)


#Filtering for goals
playergoals <- filter(shots1315, isgoal == TRUE)
playergoals <- group_by(playergoals, primaryplayer)
playergoals <- summarise(playergoals, shots = n())
playergoals <- rename(.data = playergoals, goals = shots)

playerfinaldataset <- merge(playertempdata, playergoals, by = c("primaryplayer"), all.x = TRUE)

#Creating Ratios
playerfinaldataset <- mutate(playerfinaldataset, ShootingAcc = (onTarget/shots)*100, Conversion = (goals/onTarget)*100)
