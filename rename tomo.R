url <- "http://www.bbc.com/sport/football/premier-league/table"

page <- html(url)

urls <- page %>%
    html_nodes("#trc-20-premier-league-CFBB82014S1R1 .team-name a") %>%
    html_attr("href")

urls <- urls[!is.na(urls)]

linknames <- page %>%
    html_nodes(".report") %>%
    html_text()


citylinks <- paste0("http://www.bbc.com",urls,"/results")
