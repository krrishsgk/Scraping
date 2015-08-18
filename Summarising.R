#Trying out all the summarising and group bys

#Merging the shot datasets

shots1315 <- rbind(shots1314, shots1415)

#Summarising
library(data.table)
library(dplyr)

byPlayer <- group_by(shots1315, primaryplayer,  shotposition)
byPlayer <-summarise(byPlayer, shots = n())

SoT <- filter(shots1315, goalposition != "NA")
SoT <- group_by(shots1315, primaryplayer,  shotposition)
SoT <- summarise(byPlayer, shots = n())

  
  
df2 <- df %>%
  filter(A == "foo") %>%
  group_by(ID) %>%
  summarize(sumBfoo = sum(B))