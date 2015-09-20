#Assigning each shot random coordinates based on the zone it is located in

#Scraping a random game
unitedgame <- "http://www.bbc.com/sport/football/29090585"
unitedgame <- getmatchdata(unitedgame)
unitedgame <- makedata(unitedgame)
unitedgame <- unitedgame[which(unitedgame$eventType == "shot"),]


#Take each shot, assign it random coordinates based on its zone
shottypes <- c("free kick","Penalty|penalty","very close range","centre of the box","outside the box","a difficult angle on the right",
               "a difficult angle on the left","left side of the box","right side of the box",
               "right side of the six yard box","left side of the six yard box",
               "from a difficult angle and long range on the right",
               "from a difficult angle and long range on the left", "from more than 35 yards",
               "long range on the left","long range on the right",
               "from more than 40 yards on the right wing","from more than 40 yards on the left wing")

shotForms <- c(c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),
               c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),
               c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),
               c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),c(runif(1),runif(1)),
               c(runif(1),runif(1)),c(runif(1),runif(1)))

for (i in 1:length(shottypes)) {
  unitedgame$coordinates[grepl(shottypes[i],unitedgame$livetext, perl=TRUE)] <- shotForms[i]
}
