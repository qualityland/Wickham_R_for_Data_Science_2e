# install packages used in the book
install.packages(c("babynames", "gapminder", "nycflights13", "palmerpenguins"))

install.packages(
  c("arrow", "babynames", "curl", "duckdb", "gapminder", "ggrepel", "ggridges",
    "ggthemes", "hexbin", "janitor", "Lahman", "leaflet", "maps",
    "nycflights13", "openxlsx", "palmerpenguins", "repurrrsive", "tidymodels",
    "writexl"
  )
)

# list of data sets in a specific package
data(package="ggplot2")$results[, "Item"]

# list of data sets available in base R
sort(data()$results[, "Item"])
