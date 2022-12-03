library(tidyverse)
library(babynames)

curr_pkgs <- read_delim("data/curr_contr.txt", delim = "\t", na = "-")

# show different file types
table(curr_pkgs$Icon)

# remove 
curr_pkgs <- curr_pkgs |>
  filter(Icon == "[   ]") |>
  rename(File=Name) |>
  mutate(Name_Version=str_extract(File, ".*(?=.tar.gz)")) |>
  separate(Name_Version, into = c("Name", "Version"), sep = "_") |>
  #mutate(c(Name, Version)=strsplit(Name_Version, "_")) |>
  select(Name, Version, File, Last_modified, Size)

curr_pkgs



