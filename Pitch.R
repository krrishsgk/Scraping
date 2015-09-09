#Drawing a pitch

library(ggplot2)

#A function to draw a circle
circleFunc <- function(centre = c(0,0), diameter = 1, npoints = 100, start = 0, end = 2)
{
  tt <- seq(start*pi, end*pi, length.out = npoints)
  xx <- centre[1] + diameter / 2 * cos(tt)
  yy <- centre[2] + diameter / 2 * sin(tt)
  return(data.frame(x = xx, y = yy))
}


dat <- circleFunc(c(1,-1),2.3,npoints = 100)
#geom_path will do open circles, geom_polygon will do filled circles
ggplot(dat,aes(x,y)) + geom_path()

centerCircle <- circleFunc(c(50,50), 2.5)
abc <- ggplot(centerCircle, aes(x,y)) + geom_path()
#the fill argument is for the colour inside and the colour argument is for the outline

pitchOutline <- geom_rect(aes(xmin = 0, xmax = 100, ymin = 0, ymax = 100), fill = "light green", colour = "black", size = 1)
halfwayLine <-  geom_rect(aes(xmin = 0, xmax = 50, ymin = 0, ymax = 100), fill = NA, colour = "black", size = 1) 
LHSpenaltyBox <- geom_rect(aes(xmin = 0, xmax = 17, ymin = 21, ymax = 79), fill = NA, colour = "black", size = 1)
RHSpenaltyBox <- geom_rect(aes(xmin = 83, xmax = 100, ymin = 21, ymax = 79), fill = NA, colour = "black", size = 1)
LHS6yardBox <- geom_rect(aes(xmin = 0, xmax = 6, ymin = 36.8, ymax = 63.2), fill = NA, colour = "black", size = 1)
RHS6yardBox <- geom_rect(aes(xmin = 94, xmax = 100, ymin = 36.8, ymax = 63.2), fill = NA, colour = "black", size = 1)
LHSpenSpot <- geom_point(aes(x = 11.33, y = 50))
RHSpenSpot <- geom_point(aes(x = 88.67, y = 50))
noFill <- theme(rect = element_blank(), line = element_blank(), text = element_blank())
#element_blank removes the gridlines inside

#Shooting zones
closeRange <- geom_rect(aes(xmin = 0, xmax = 6, ymin = 45.6, ymax = 54.4), fill = NA, colour = "black", size = 0.5)
RS6Box <- geom_rect(aes(xmin = 0, xmax = 6, ymin = 54.4, ymax = 63.2), fill = NA, colour = "black", size = 0.5)
LS6Box <- geom_rect(aes(xmin = 0, xmax = 6, ymin = 36.8, ymax = 45.6), fill = NA, colour = "black", size = 0.5)
CBox <- geom_rect(aes(xmin = 6, xmax = 17, ymin = 36.8, ymax = 63.2), fill = NA, colour = "black", size = 0.5)
LSBox <- geom_rect(aes(xmin = 0, xmax = 17, ymin = 21, ymax = 36.8), fill = NA, colour = "black", size = 0.5)
RSBox <- geom_rect(aes(xmin = 0, xmax = 17, ymin = 63.2, ymax = 79), fill = NA, colour = "black", size = 0.5)
DiffAngL <- geom_rect(aes(xmin = 0, xmax = 17, ymin = 0, ymax = 21), fill = NA, colour = "black", size = 0.5)
DiffAngR <- geom_rect(aes(xmin = 0, xmax = 17, ymin = 79, ymax = 100), fill = NA, colour = "black", size = 0.5)
OBox <- geom_rect(aes(xmin = 17, xmax = 30, ymin = 21, ymax = 79), fill = NA, colour = "black", size = 0.5)
DiffAngLongL <- geom_rect(aes(xmin = 17, xmax = 30, ymin = 0, ymax = 21), fill = NA, colour = "black", size = 0.5)
DiffAngLongR <- geom_rect(aes(xmin = 17, xmax = 30, ymin = 79, ymax = 100), fill = NA, colour = "black", size = 0.5)
Yards35Plus <- geom_rect(aes(xmin = 30, xmax = 38.67, ymin = 21, ymax = 79), fill = NA, colour = "black", size = 0.5)
LongL <- geom_rect(aes(xmin = 30, xmax = 38.67, ymin = 0, ymax = 21), fill = NA, colour = "black", size = 0.5)
LongR <- geom_rect(aes(xmin = 30, xmax = 38.67, ymin = 79, ymax = 100), fill = NA, colour = "black", size = 0.5)
Plus40L <- geom_rect(aes(xmin = 38.67, xmax = 52, ymin = 0, ymax = 50), fill = NA, colour = "black", size = 0.5)
Plus40R <- geom_rect(aes(xmin = 38.67, xmax = 52, ymin = 50, ymax = 100), fill = NA, colour = "black", size = 0.5)


footballPitch <- ggplot() + pitchOutline + halfwayLine + 
  LHSpenaltyBox + RHSpenaltyBox + LHS6yardBox + RHS6yardBox + 
  noFill + LHSpenSpot + RHSpenSpot + #these are the zones. remove after finalising
  closeRange + RS6Box + LS6Box + CBox + LSBox + RSBox + DiffAngL + DiffAngR + 
    OBox + DiffAngLongL + DiffAngLongR + Yards35Plus + LongL + LongR +
    Plus40L + Plus40R


("FreeKick","pen","CloseRange","CBox","OBox","DiffAngR","DiffAngL","LSBox","RSBox","RS6Box",
 "LS6Box", "DiffAngLongR","DiffAngLongL","35YardsPlus","LongL","LongR","40PlusR","40PlusL"
 
#Code to use if you have ExpG. Ignore geom_segment though
b <- ggplot(test, aes(x,y)) + geom_point() + geom_segment(aes(x = 0, y = 0, xend = 0, yend = 100)) +
  geom_segment(aes(x = 100, y = 0, xend = 100, yend = 100)) + 
  geom_segment(aes(x = 0, y = 0, xend = 100, yend = 0)) + 
  geom_segment(aes(x = 0, y = 100, xend = 100, yend = 100)) + 
  geom_segment(aes(x=50, y= 0, xend = 50, yend = 100)) + 
  geom_segment(aes(x=0, y=21, xend = 17, yend=21)) + 
  geom_segment(aes(x=17, y=21, xend = 17, yend=79)) + 
  geom_segment(aes(x=0, y=79, xend = 17, yend= 79)) + 
  geom_segment(aes(x=50, y= 0, xend = 50, yend = 100)) + 
  geom_segment(aes(x=5.8, y= 36.8, xend = 0, yend = 36.8)) + 
  geom_segment(aes(x=0, y=63.2, xend = 5.8, yend = 63.2)) + 
  geom_segment(aes(x=5.8, y=36.8, xend = 5.8, yend = 63.2))+ 
  geom_segment(aes(x=83, y=21.2, xend=100, yend=21.2)) + 
  geom_segment(aes(x=83, y=21, xend=83, yend=79)) + 
  geom_segment(aes(x=83, y=79, xend=100, yend=79))+ 
  geom_segment(aes(x=100, y=36.8, xend=94.2, yend=36.8)) +
  geom_segment(aes(x=94.2, y=36.8, xend=94.2, yend=63.2)) + 
  geom_segment(aes(x=100, y= 63.2, xend=94.2, yend=63.2)) +
  geom_point(aes(size= xG))
