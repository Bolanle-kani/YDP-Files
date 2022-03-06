
## Function to extract all links for chats
extract_links <- function(tbl){
  
  url_pattern <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  
  tbl %>% 
    filter(time > read_lines("data/last_date.txt")) %>% 
    select(time, author, text) %>% 
    filter(str_detect(text, url_pattern), !is.na(author)) %>% 
    mutate(url = str_extract_all(text, url_pattern)) %>% 
    unnest(url) %>% 
    select(-text)
  
}

## Function to save this new tbl of link using the date period filename

export_links <- function(tbl){
  
  from = min(as.Date(tbl$time), na.rm = T)
  to = max(as.Date(tbl$time), na.rm = T)
  
  address <- paste("processed_links/",from,"to",to,".csv", sep = "")
  
  tbl %>%
    write_csv(address)
}

## Function to get the latest date

get_last_chat_date <- function(tbl){
  max_date <- max(tbl$time, na.rm = T)
  
  write_lines(max_date, "data/last_date.txt")
  
}

  
                                              