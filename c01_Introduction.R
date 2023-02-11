# install packages used in the book
install.packages(c("babynames", "gapminder", "nycflights13", "palmerpenguins"))

# list of data sets in a specific package
data(package="ggplot2")$results[, "Item"]

# list of data sets available in base R
sort(data()$results[, "Item"])
