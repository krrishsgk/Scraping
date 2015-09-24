#Assigning each shot random coordinates based on the zone it is located in

#Scraping a random game
unitedgame <- "http://www.bbc.com/sport/football/29090585"
unitedgame <- getmatchdata(unitedgame)
unitedgame <- makedata(unitedgame)
unitedgame <- unitedgame[which(unitedgame$eventType == "shot"),]


#Take each shot, assign it random coordinates based on its zone
shottypes <- c("very close range","centre of the box","outside the box","a difficult angle on the right",
               "a difficult angle on the left","left side of the box","right side of the box",
               "right side of the six yard box","left side of the six yard box",
               "from a difficult angle and long range on the right",
               "from a difficult angle and long range on the left", "from more than 35 yards",
               "long range on the left","long range on the right",
               "from more than 40 yards on the right wing","from more than 40 yards on the left wing")


xCoordFunc <- function(shotPos)
{
    switch(shotPos,
           "CloseRange" = runif(1,min=0,max=6),
           "CBox" = runif(1,min=6,max=17),
           "OBox" = runif(1,min=17,max=30),
           "DiffAngR" = runif(1,min=0,max=17),
           "DiffAngL" =  runif(1,min=0,max=17),
           "LSBox" = runif(1,min=0,max=17),
           "RSBox" =  runif(1,min=0,max=17),
           "RS6Box" = runif(1,min=0,max=6),
           "LS6Box" = runif(1,min=0,max=6),
           "DiffAngLongR" = runif(1,min=17,max=30),
           "DiffAngLongL" = runif(1,min=17,max=30),
           "35YardsPlus" = runif(1,min=30,max=38.67),
           "LongL" = runif(1,min=30,max=38.67),
           "LongR" = runif(1,min=30,max=38.67),
           "40PlusR" = runif(1,min=38.67,max=52),
           "40PlusL" = runif(1,min=38.67,max=52)
           )
}

yCoordFunc <- function(shotPos)
{
  switch(shotPos,
         "CloseRange" = runif(1,min=45.6,max=54.4),
         "CBox" = runif(1,min=36.8,max=63.2),
         "OBox" = runif(1,min=21,max=79),
         "DiffAngR" = runif(1,min=79,max=100),
         "DiffAngL" =  runif(1,min=0,max=21),
         "LSBox" = runif(1,min=21,max=36.8),
         "RSBox" =  runif(1,min=63.2,max=79),
         "RS6Box" = runif(1,min=54.4,max=63.2),
         "LS6Box" = runif(1,min=36.8,max=45.6),
         "DiffAngLongR" = runif(1,min=79,max=100),
         "DiffAngLongL" = runif(1,min=0,max=21),
         "35YardsPlus" = runif(1,min=21,max=79),
         "LongL" = runif(1,min=0,max=21),
         "LongR" = runif(1,min=79,max=100),
         "40PlusR" = runif(1,min=0,max=50),
         "40PlusL" = runif(1,min=50,max=100)
  )
}

unitedgame$xCord <- lapply(unitedgame$shotposition,FUN=xCoordFunc)
unitedgame$yCord <- lapply(unitedgame$shotposition,FUN=yCoordFunc)


xy <- matrix(runif(20), ncol = 2)  # a matrix with some arbitrary points as coordinates..
xy.sp <- SpatialPoints(xy)  # ..converted into a spatial object
plot(xy.sp, pch = 2)