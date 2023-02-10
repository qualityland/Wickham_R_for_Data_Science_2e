library(tidyverse)
library(palmerpenguins)


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







# flipper length vs body mass
ggplot(penguins, aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(aes(color=species)) +
  geom_smooth() +
  labs(
    title = "Body Mass and Flipper Lenght",
    subtitle = "Dimensions for Adelie, Chinstrap and Geentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)")
