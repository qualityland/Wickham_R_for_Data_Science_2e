library(tidyverse)
library(babynames)

# load current contributed packages
curr_pkgs <- read_delim("data/curr_contr.txt", delim = "\t", na = "-")

# show different file types
#table(curr_pkgs$Icon)

# remove directories and textfiles and add package name and version
curr_pkgs <- curr_pkgs |>
  filter(Icon == "[   ]") |>
  rename(File=Name) |>
  mutate(Name_Version=str_extract(File, ".*(?=.tar.gz)")) |>
  separate(Name_Version, into = c("Name", "Version"), sep = "_") |>
  filter(!is.na(Name)) |>
  select(Name, Version, File, Last_modified, Size) |> 
  arrange(Name, Version)

curr_pkgs

curr_pkgs |> 
  group_by(Name) |> 
  filter(n()>1) |> 
  as.data.frame()


eb_text <- read_lines("data/R-4.2.1-foss-2022a.eb", skip = 96)

eb_pkgs <- tibble(text=eb_text)

eb_pkgs <- eb_pkgs |> 
  mutate(Name_Version=str_extract(text, "(?<=    \\(').*(?=', \\{)")) |> 
  select(Name_Version) |> 
  filter(!is.na(Name_Version)) |> 
  separate(Name_Version, into = c("Name", "Version"), sep = "', '") |> 
  arrange(Name, Version)

eb_pkgs


#####
# On command line execute this:
# curl -s https://cran.r-project.org/src/contrib/ | grep -o 'href=".*">' \\
#   | sed -e "s/href=\"//g" | sed -e "s/\"\>/,/g" |grep ".tar.gz" \\
#   | sed -e "s/\.tar\.gz<\/a><\/td>.*//g" > curr_cont.txt



curr_pkgs <- read_csv("data/curr_cont.txt")
# remove directories and textfiles and add package name and version
curr_pkgs |>
  separate(Name_Version, into = c("Name", "Version"), sep = "_")
  
  filter(Icon == "[   ]") |>
  rename(File=Name) |>
  mutate(Name_Version=str_extract(File, ".*(?=.tar.gz)")) |>
  separate(Name_Version, into = c("Name", "Version"), sep = "_") |>
  filter(!is.na(Name)) |>
  select(Name, Version, File, Last_modified, Size) |> 
  arrange(Name, Version)



#####
library(RCurl)
url <- 'https://cran.r-project.org/src/contrib/'
filenames = getURL(url, ftp.use.epsv = FALSE, dirlistonly = TRUE)


# Deal with newlines as \n or \r\n. (BDR)
# Or alternatively, instruct libcurl to change \n’s to \r\n’s for us with crlf = TRUE
# filenames = getURL(url, ftp.use.epsv = FALSE, ftplistonly = TRUE, crlf = TRUE)
filenames = paste(url, strsplit(filenames, "\r*\n")[[1]], sep = "")
