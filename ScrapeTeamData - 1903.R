#Code to open all match reports of a team and get their match commn
#This code does it team by team. Try it league by league?

cityurl <- "http://www.bbc.com/sport/football/teams/manchester-united/results"



teamlinks <- function(teamurl)
{

bbcprefix <- "http://www.bbc.com"

page <- html(teamurl)

reportlinks <- page %>%
    html_nodes(".report") %>%
    html_attr("href")

reportlinks <- reportlinks[!is.na(reportlinks)]

hometeam <- page %>%
    html_nodes(".team-home") %>%
    html_text()%>%
    str_trim

awayteam <- page %>%
    html_nodes(".team-away") %>%
    html_text()%>%
    str_trim

score <- page %>%
    html_nodes("abbr") %>%
    html_text()
score <- score[grepl("-",score)] %>%
    str_trim

date <- page %>%
    html_nodes(".match-date") %>%
    html_text()

date <- date[!grepl(pattern="Date",x=date)] %>%
    str_trim

competition <- page %>%
    html_nodes(".match-competition") %>%
    html_text()
competition <- competition[!grepl(pattern="Competition",x=competition)]%>%
    str_trim

matchlinks <- paste0(bbcprefix ,reportlinks)

teamframe <- data.frame(competition,hometeam,awayteam,score,date,matchlinks, stringsAsFactors=FALSE)
return(teamframe)
}
