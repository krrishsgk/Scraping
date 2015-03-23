#Code to open all match reports of a team and get their match commn
#This code does it team by team. Try it league by league?

cityurl <- "http://www.bbc.com/sport/football/premier-league/results"



leaguelinks <- function(leagueurl)
{
    
    bbcprefix <- "http://www.bbc.com"
    
    page <- html(leagueurl)
    
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
    
    
    matchlinks <- paste0(bbcprefix ,reportlinks)
    
    teamframe <- data.frame(hometeam,awayteam,score,matchlinks,stringsAsFactors=FALSE)
    return(teamframe)
}
