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


# 2.2.1 The Penguins Data Frame
# -----------------------------

# 1st look at penguins tibble
penguins
glimpse(penguins)
str(penguins)

# --------------------------------------------------------------------------------------------------
# Question: Do penguins with longer flippers weigh more or less than penguins with shorter flippers?
# --------------------------------------------------------------------------------------------------


# 2.2.3 Creating a ggplot
# -----------------------

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
# or
colSums(is.na(penguins))
# or
summary(penguins)


# 2.2.4 Adding Aesthetics and Layers
# ----------------------------------

# add color as a 3rd variable
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point()

# add 2nd geometric object: smooth curve (one for EVERY species)
# (3rd variable set on global level [ggplot()] is inherited by all geoms)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  geom_smooth(method = "lm")

# add 2nd geometric object: smooth curve (one for ALL species)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth()

# additionally to color, also map 'species' to the shape aesthetic
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

# improve labels and support for colorblind folks
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()


# 2.2.5 Exercises
# ---------------

# 1. How many rows are in penguins? How many columns?
nrow(penguins)
ncol(penguins)
# or
dim(penguins)

# 2. What does the bill_depth_mm variable in the penguins data frame describe?
#    Read the help for ?penguins to find out.
?penguins
# a number denoting bill depth (in mm)

# 3. Make a scatterplot of bill_depth_mm vs. bill_length_mm.
#    That is, make a scatterplot with bill_depth_mm on the y-axis and
#    bill_length_mm on the x-axis. Describe the relationship between these
#    two variables.
ggplot(penguins, aes(bill_length_mm, bill_depth_mm)) +
  geom_point() +
  geom_smooth(method = "lm")

# 4. What happens if you make a scatterplot of species vs. bill_depth_mm?
ggplot(penguins, aes(bill_depth_mm, species)) +
  geom_jitter()
#    What might be a better choice of geom?
ggplot(penguins, aes(species, bill_depth_mm)) +
  geom_boxplot()
# or
ggplot(penguins, aes(bill_depth_mm, color = species)) +
  geom_density()

# 5. Why does the following give an error and how would you fix it?
ggplot(data = penguins) + 
  geom_point()
# fix:
ggplot(penguins, aes(bill_depth_mm, body_mass_g, color = species)) +
  geom_point()

# 6. What does the na.rm argument do in geom_point()?
#    What is the default value of the argument?
#    Create a scatterplot where you successfully use this argument set to TRUE.
ggplot(penguins,
       aes(
         flipper_length_mm,
         body_mass_g,
         color = species,
         shape = species
       )) +
  geom_point(na.rm = TRUE) # inhibits warning message!

# 7. Add the following caption to the plot you made in the previous exercise:
#    “Data come from the palmerpenguins package.”
#    Hint: Take a look at the documentation for labs().
ggplot(penguins,
       aes(
         flipper_length_mm,
         body_mass_g,
         color = species,
         shape = species
       )) +
  geom_point() +
  scale_color_colorblind() +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species",
    caption = "Data come from the palmerpenguins package."
  )

# 8. Recreate the following visualization.
#    What aesthetic should bill_depth_mm be mapped to?
#    And should it be mapped at the global level or at the geom level?
ggplot(penguins, aes(flipper_length_mm, body_mass_g, color = bill_depth_mm)) +
  geom_point()

# 9. Run this code in your head and predict what the output will look like.
#    Then, run the code in R and check your predictions.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# 10. Will these two graphs look different? Why/why not?
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
# no difference, since all global properties have been copied to both geoms.


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


# 2.5.1 A Numerical and a Categorical Variable
# --------------------------------------------

# boxplot
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

# frequency polygon
ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_freqpoly(binwidth = 200, linewidth = .75)


# density plot
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species) ) +
  geom_density(alpha = 0.5)


# 2.5.2 Two Categorical Variables
# -------------------------------

# barplot
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

# barplot with relative proportions
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")


# 2.5.3 Two Numerical Variables
# -----------------------------

# scatter plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

# 2.5.4 Three or more Variables
# -----------------------------

# scatter plot with color and shape
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))


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
