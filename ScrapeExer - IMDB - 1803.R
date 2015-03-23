library(stringr)
movieUrl <- "http://www.imdb.com/title/tt0137523/"
moviePage <- html(movieUrl)

actors <- moviePage %>%
    html_nodes("#titleCast .itemprop span") %>%
    html_text()

roles <- moviePage %>%
    html_nodes(".character div") %>%
    html_text() %>%
    str_replace_all(pattern="[\r\n]","") %>%
    str_trim()

data.frame(actors,roles)
html_text(cast)



#Experimental code to try and extract data from multiple links

url <- "http://www.bbc.com/sport/football/teams/manchester-city/results"
page <- html(url)
urls <- page %>%
    html_nodes(".report") %>%
    html_attr("href")
urls <- urls[!is.na(urls)]

linknames <- page %>%
    html_nodes(".ver12 a") %>%
    html_text()

paste0("http://www.bbc.com",urls[49])
