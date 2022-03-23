library(targets)

source("R/function.R")

options(tidyverse.quiet = TRUE)

# Set target-specific options such as packages.
tar_option_set(packages = c("tidyverse","rwhatsapp"))

# End this file with a list of target objects.
list(
  tar_target(chat_data_file, "data/chat_data.txt", format = "file"),
  
  tar_target(load_chat_data, rwa_read(chat_data_file)),
  
  tar_target(get_links, extract_links(load_chat_data)),
  
  tar_target(save_links, export_links(get_links)),
  
  tar_target(save_latest_datetime, get_last_chat_date(get_links))
)
