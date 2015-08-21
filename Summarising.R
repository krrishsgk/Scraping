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
dump <- shots1415[temp,]
byPlayer <- group_by(shots1315, primaryplayer, shotposition, foot)
byPlayer <-summarise(byPlayer, shots = n())

#Filtering for on target shots
SoT <- filter(shots1315, goalposition != "NA")
SoT <- group_by(SoT, primaryplayer,  shotposition, foot)
SoT <- summarise(SoT, shots = n())
SoT <- rename(.data = SoT, onTarget = shots)

finaldataset <- merge(byPlayer, SoT, by = c("primaryplayer", "shotposition","foot"), all.x = TRUE)

