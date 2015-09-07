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


footballPitch <- ggplot() + pitchOutline + halfwayLine + 
  LHSpenaltyBox + RHSpenaltyBox + LHS6yardBox + RHS6yardBox + 
  noFill + LHSpenSpot + RHSpenSpot 


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
