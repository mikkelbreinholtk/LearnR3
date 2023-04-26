# Loading packages --------------------------------------------------------

library(tidyverse)
install.packages("NHANES")
library(NHANES)


# Looking at data ---------------------------------------------------------
glimpse(NHANES)


# How to use select() from tidyverse --------------------------------------
# Selecting columns
select(NHANES, Age)
# Selecting severel columns
select(NHANES, Age, Weight, BMI)
# Selecting every colums, but the ones mentionend
select(NHANES, -HeadCirc)
# Selecting variables (strings) starting with "BP"
select(NHANES, starts_with("BP"))
# Selecting variables (strings) that ends with "Day"
select(NHANES, ends_with("Day"))
# Select variables that contain "Age"
select(NHANES, contains("Age"))



# Create smaller NHANES dataset -------------------------------------------
# Selecting variables for smaller dataset
nhanes_small <- select(
  NHANES, Age, Gender, BMI, Diabetes,
  PhysActive, BPSysAve, BPDiaAve, Education
)
# Printing the dataset
nhanes_small

# Renaming columns. Remember that you can not use () for fn inside fn
nhanes_small <- rename_with(
  nhanes_small,
  snakecase::to_snake_case
)
nhanes_small

# Renaming "gender" to "sex"
nhanes_small <- rename(nhanes_small, sex = gender)
nhanes_small


# Trying the pipe operator -------------------------------------------------
# Listing the column names of the dataset
colnames(nhanes_small)

# Listing the colnames but with piping insted.
nhanes_small %>%
  colnames()

# Selecting in nhanes_small, and then piping the output
# of the function "select()" in to the "rename()" function
nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

# Exercise 7.8 ------------------------------------------------------------

nhanes_small %>%
  select(bp_sys_ave, education)

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

# Rewrite the following code using %>%
select(nhanes_small, bmi, contains("age"))

nhanes_small %>%
  select(
    bmi,
    contains("age")
  )

# Rewrite the following code using %>%
blood_pressure <- select(nhanes_small, starts_with("bp_"))
rename(blood_pressure, bp_systolic = bp_sys_ave)

nhanes_small %>%
  select(starts_with("bp")) %>%
  rename(bp_systolic = bp_sys_ave)
