# ------------------------------------------------------------------------------
# 2.1 Introduction
# ------------------------------------------------------------------------------

# install.packages(c("babynames", "gapminder", "nycflights13", "palmerpenguins"))
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# ------------------------------------------------------------------------------
# 2.2 First Steps
# ------------------------------------------------------------------------------

# 1st look at penguins tibble
penguins
glimpse(penguins)
str(penguins)

# --------------------------------------------------------------------------------------------------
# Question: Do penguins with longer flippers weigh more or less than penguins with shorter flippers?
# --------------------------------------------------------------------------------------------------

# Plot Object

# create a plot object
ggplot(data = penguins)


# Aesthetics Mapping

# map 1st variable from data frame to a visual property (x) of plot
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm))

# map 2nd variable to a visual property (y)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g))

# define a geom
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

# check for penguins having NA
# in either flipper length or body mass
# (see warning message triggered by above plot)
penguins |>
  select(species, flipper_length_mm, body_mass_g) |>
  filter(is.na(flipper_length_mm) | is.na(body_mass_g))

# add color as a 3rd variable
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point()

# add 2nd geometric object: smooth curve (one for EVERY species)
# (3rd variable set on global level [ggplot()] is inherited by all geoms)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  geom_smooth()

# add 2nd geometric object: smooth curve (one for ALL species)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth()

# additionally to color, also map 'species' to the shape aesthetic
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth()

# improve labels and support for colorblind folks
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth() +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

# ------------------------------------------------------------------------------
# 2.3 ggplot2 Calls
# ------------------------------------------------------------------------------

# more concise
ggplot(penguins, aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point()

# same using pipe (R 4.1+)
penguins |>
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()




# ------------------------------------------------------------------------------
# 2.4 Visualizing Distributions
# ------------------------------------------------------------------------------

# 2.4.1 Categorical Variables
# ---------------------------

# distribution of species
ggplot(penguins, aes(x=species)) +
  geom_bar()

# ordered by frequencies
ggplot(penguins, aes(x=fct_infreq(species))) +
  geom_bar()


# 2.4.2 Numerical Variables
# -------------------------

# barplot
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

# density plot
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

# ------------------------------------------------------------------------------
# 2.5 Visualizing Relationships
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# 2.6 Saving your Plots
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# 2.7 Common Problems
# ------------------------------------------------------------------------------




# ------------------------------------------------------------------------------
# Bullshit and Try-outs
# ------------------------------------------------------------------------------

# flipper length vs body mass
ggplot(penguins, aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(aes(color=species)) +
  geom_smooth() +
  labs(
    title = "Body Mass and Flipper Lenght",
    subtitle = "Dimensions for Adelie, Chinstrap and Geentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)")




# mpg data
ggplot(data = mpg, mapping= aes(x = displ, y = hwy, color = class)) +
  geom_point()





ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(aes(color = species)) +
  geom_smooth()
