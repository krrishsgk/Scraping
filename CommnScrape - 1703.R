install.packages("magrittr")
install.packages("rvest")

#Saving the required page in a variable and reading it
pageLink <- "http://www.bbc.com/sport/0/football/31826980"
barcaCity <- "http://www.bbc.com/sport/0/football/31922160"

getmatchdata <- function(url)
{
library(magrittr)
library(rvest)
library(stringr)

page <- html(x=url)

#extracting match commn through thr html tag associated with it
livetext <- page %>%
    html_nodes('#live-text-commentary-wrapper .blq-clearfix p') %>%
    html_text() %>%
    gsub("^\\s+|\\s+$", "", .)

#extracting respective match time tags
mins <- page %>%
    html_nodes('.live-text span') %>%
    html_text()

#removing reduntant commentary like full time
livetext <- livetext[!grepl(pattern="Match ends", livetext, ignore.case=TRUE )]

#Two ways to clean the data
cleanMins1 <- mins %>%
    gsub("[\\sa-zA-Z!]","",.) %>%
    gsub("(:).*","",.)

cleanMins2 <- mins %>%
    gsub("[A-z!]","",.) %>%
    gsub("(:).*","",.)

#Removing entries which don't have numbers and entries which have +
cleanMins1 <- cleanMins1[grepl("[0-9]", cleanMins1) & !grepl("[+]",cleanMins1)] %>%
    as.numeric()

matchdata <- data.frame(cleanMins1, livetext, stringsAsFactors=FALSE)

return(matchdata)
}
