library(tidyverse)
library(babynames)


cmd <- r"(curl -s https://cran.r-project.org/src/contrib/ | grep -o 'href=".*">'  | sed -e "s/href=\"//g" | sed -e "s/\"\>/,/g" |grep ".tar.gz"  | sed -e "s/\.tar\.gz<\/a><\/td>.*//g")"
lines <- system(cmd, intern = TRUE)
df <- tibble(Line=lines)

df <- df |> 
  separate(Line, into = c("File", "Name_Version"), sep = ",") |> 
  separate(Name_Version, into = c("Name", "Version"), sep = "_")

curr_pkgs <- df |> 
  group_by(Name) |> 
  #filter(File!="qgcomp_2.9.0.tar.gz") |> 
  mutate(curr_Version=max(Version)) |> 
  filter(Version==curr_Version) |> 
  arrange(Name) |> 
  select(Name, curr_Version, File) |> 
  ungroup()

eb_text <- read_lines("data/R-4.2.1-foss-2022a.eb", skip = 96)

eb_pkgs <- tibble(text=eb_text)

eb_pkgs <- eb_pkgs |> 
  mutate(Name_Version=str_extract(text, "(?<=    \\(').*(?=', \\{)")) |> 
  select(Name_Version) |> 
  filter(!is.na(Name_Version)) |> 
  separate(Name_Version, into = c("Name", "eb_Version"), sep = "', '")

new_eb_pkgs <- eb_pkgs |> 
  left_join(curr_pkgs, by = "Name") |> 
  select(Name, curr_Version, File) |> 
  rename(Version=curr_Version)

# URLs and download destinations
urls <- paste0("https://cran.r-project.org/src/contrib/", new_eb_pkgs$File)
dests <- paste0("~/Downloads/eb/", new_eb_pkgs$File)

# download source files
for(i in seq_along(urls)){
  download.file(urls[i], dests[i], method="curl")
}


# sha256sum
few_dests <- head(dests)
for(i in seq_along(few_dests)){
  shasum <- system(paste("shasum -a 256", few_dests[i]), intern = TRUE)
  print(shasum)
}










# load current contributed packages
#curr_pkgs <- read_delim("data/curr_contr.txt", delim = "\t", na = "-")

# show different file types
#table(curr_pkgs$Icon)

# remove directories and textfiles and add package name and version
# curr_pkgs <- curr_pkgs |>
#   filter(Icon == "[   ]") |>
#   rename(File=Name) |>
#   mutate(Name_Version=str_extract(File, ".*(?=.tar.gz)")) |>
#   separate(Name_Version, into = c("Name", "Version"), sep = "_") |>
#   filter(!is.na(Name)) |>
#   select(Name, Version, File, Last_modified, Size) |> 
#   arrange(Name, Version)
# 
# curr_pkgs <- curr_pkgs |> 
#   rename(curr_Version=Version)
# 
# 
# curr_pkgs |> 
#   group_by(Name) |> 
#   filter(n()>1) |> 
#   as.data.frame()





#####
# On command line execute this:
# curl -s https://cran.r-project.org/src/contrib/ | grep -o 'href=".*">' \\
#   | sed -e "s/href=\"//g" | sed -e "s/\"\>/,/g" |grep ".tar.gz" \\
#   | sed -e "s/\.tar\.gz<\/a><\/td>.*//g" > curr_cont.txt



# curr_pkgs <- read_csv("data/curr_cont.txt")
# # remove directories and textfiles and add package name and version
# curr_pkgs <- curr_pkgs |>
#   separate(Name_Version, into = c("Name", "Version"), sep = "_")
  
