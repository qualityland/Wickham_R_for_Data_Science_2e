library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# Tidy Data:
# - observations in their own row
# - variables in their own column
# - values in their own cell

# tibble
penguins

# variables and some values
glimpse(penguins)

# variable statistics and NAs
summary(penguins)

# 1st visualization
ggplot(data = penguins)

# mapping variables to aestetics (visual properties)
ggplot(penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g))

# define geometrical object (bar, boxplot, point, line, jitter...)
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point()

# add color
ggplot(
  data = penguins,
  mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g, 
    color = species
    )
) +
  geom_point()

# add linear model
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")

# move aesthetic mapping for color from global to local level (geom_point)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")

# map different shape to each species
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

# add title, subtitle and nice labels
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, )) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap and Gentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    color = "Species",
    shape = "Species"
  )

# make colors colorblind safe
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, )) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap and Gentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    color = "Species",
    shape = "Species"
  ) +
  scale_color_colorblind()

# Exercises 1.2.5
# 1
dim(penguins)

# 2
?penguins

# 3
ggplot(penguins, aes(bill_depth_mm, bill_length_mm)) +
  geom_point(mapping = aes(color = species, shape = sex))

# 4
ggplot(penguins, aes(species, bill_depth_mm)) +
  geom_point()
 # better:
ggplot(penguins, aes(species, bill_depth_mm)) +
  geom_boxplot()

# 5
# aesthetic mapping added
ggplot(data = penguins) + 
  geom_point(aes(bill_depth_mm, bill_length_mm))

# 6
# NAs are silently removed if na.rm = TRUE
ggplot(penguins, aes(bill_depth_mm, bill_length_mm)) +
  geom_point(mapping = aes(color = species, shape = sex),
             na.rm = TRUE)

# 7
ggplot(penguins, aes(bill_depth_mm, bill_length_mm)) +
  geom_point(mapping = aes(color = species, shape = sex),
             na.rm = TRUE) +
  labs(caption = "Data come from the palmerpenguins package")

# 8
# bill_depth_mm mapped to color aesthetic
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(color = bill_depth_mm)) +
  geom_smooth()

# 9
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)) +
  geom_point() +
  geom_smooth(se = FALSE)
# better (if smoother for all islands):
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(color = island)) +
  geom_smooth(se = FALSE)

# 10
# not different, because ALL global aesthetic properties
# copied to ALL local geoms.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )


# pipe data into ggplot function
penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()


# 1.4 Distributions
# =================

# distribution: categorical variable
ggplot(penguins, aes(x = species)) +
  geom_bar()

# same, ordered by frequency
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

# distribution: numerical variable
ggplot(penguins, aes(body_mass_g)) +
  geom_histogram(binwidth = 200)

# same as density plot
ggplot(penguins, aes(body_mass_g)) +
  geom_density()

# Exercises 1.4.3
# 1
# 90 degree rotation
ggplot(penguins, aes(y = species)) +
  geom_bar()

# 2
ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

# 3
# defines number of bins
ggplot(penguins, aes(body_mass_g)) +
  geom_histogram(bins = 10)

# 4
ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 0.01)
# peak around 0.25, 0.5, 1, 1.25, 1.5 carat



# 1.5 Relationships
# =================

# numerical and categorical variable: boxplot
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

# numerical and categorical variable: density plot
ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density()

# density plot with opaque fill
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)
