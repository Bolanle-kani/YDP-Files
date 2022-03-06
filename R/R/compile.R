compile_all <- function(){
  
  fs::dir_ls("processed_links/") %>% 
    as_tibble() %>% 
    mutate(data = map(value, read_csv)) %>% 
    select(-value) %>% 
    unnest(data) %>% 
    write_csv("compiled_data.csv")
}