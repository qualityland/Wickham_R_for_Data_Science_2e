library(tidyverse)
library(babynames)

# load current contributed packages
curr_pkgs <- read_delim("data/curr_contr.txt", delim = "\t", na = "-")

# show different file types
table(curr_pkgs$Icon)

# remove directories and textfiles and add package name and version
curr_pkgs <- curr_pkgs |>
  filter(Icon == "[   ]") |>
  rename(File=Name) |>
  mutate(Name_Version=str_extract(File, ".*(?=.tar.gz)")) |>
  separate(Name_Version, into = c("Name", "Version"), sep = "_") |>
  #mutate(c(Name, Version)=strsplit(Name_Version, "_")) |>
  select(Name, Version, File, Last_modified, Size)

curr_pkgs


eb_text <- read_lines("data/R-4.2.1-foss-2022a.eb", skip = 96)

eb_pkgs <- tibble(text=eb_text)

eb_pkgs

eb_pkgs |> 
  mutate(Name_Version=str_extract(text, "(?<=    ((').*(?=', {{))"))
