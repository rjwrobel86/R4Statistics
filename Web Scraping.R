library(rvest)
library(xml2)
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
page <- read_html(url)

rank_data_html <- html_nodes(page,'.text-primary')
rank_data <- html_text(rank_data_html)
head(rank_data)

title_data_html <- html_nodes(page,'.lister-item-header a')
title_data <- html_text(title_data_html)
head(title_data)

runtime_data_html <- html_nodes(page,'.text-muted .runtime')
runtime_data <- html_text(runtime_data_html)
head(runtime_data)
