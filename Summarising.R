#Trying out all the summarising and group bys

#Merging the shot datasets

shots1315 <- rbind(shots1314, shots1415)

#Summarising
byPlayer <- group_by(shots1315, primaryplayer, shotposition)
byPlayer <-summarise(byPlayer, shots = n())
