library(tidyverse)
library(babynames)


# 14.2.2 Raw strings

tricky <- r"(double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'")"
str_view(tricky)


# 14.2.3 Other special characters

x <- c("one\ntwo", "one\ttwo", "\u00b5", "\U0001f604")
x
str_view(x)


# 14.2.4 Exercises

s1 <- "He said \"That's amazing!\""
str_view(s1)

s2 <- "\\a\\b\\c\\d"
str_view(s2)

s3 <- "\\\\\\\\\\\\"
str_view(s3)
# or
s4 <- r"(\\\\\\)"
str_view(s4)

# non-breaking-space
s5 <- "This\u00a0is\u00a0tricky"
str_view(s5)


# 14.3 Creating many strings from data

# generate tibble of names and add greeting
set.seed(1410)
tibble(name = c(wakefield::name(3), NA)) |>
mutate(greeting = str_c("Hi ", name, "!"))


tibble(x = c("a,b,c", "d,e", "f")) |> 
  separate_longer_delim(x, delim = ",")


tibble(x = c("1211", "1312", "21")) |> 
  separate_longer_position(x, width = 2)
