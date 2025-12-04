# Day 03 of Advent of Code 2025 ----
# https://adventofcode.com/2025/day/3

# Salient constraints ----

# The batteries are arranged into banks; each line of digits in your input corresponds to a single bank of batteries. Within each bank, you need to turn on exactly two batteries; the joltage that the bank produces is equal to the number formed by the digits on the batteries you've turned on.
# You'll need to find the largest possible joltage each bank can produce.
# The total output joltage is the sum of the maximum joltage from each bank, so in this example, the total output joltage is 98 + 89 + 78 + 92 = 357.
# There are many batteries in front of you. Find the maximum joltage possible from each bank; what is the total output joltage? 

# Load packages ----
# Replicate example 
library("stringr")
library("dplyr")
library("tidyr")

inp1 = readLines("~/R/advent-of-code/input-03-mre.R") |> as_tibble() |> 
  rename(bank_chr = value)

# for string of length Yn split into n columns wide
dim_w = nchar(inp1$bank_chr)[1]
df0 = str_split_fixed(inp1$bank_chr,"", n = dim_w) |> as_tibble()

# convert back to numeric
df1 = df0 |> mutate(across(where(is.character), as.numeric))

# compare digit in index place Y to digit in place Y+1 
# starting from the left (so, place 15)

df2 = df1 |> 
  rowwise() |> 
  mutate(answer1 = which.max(pick(everything()))) |> 
  ungroup() |> as_tibble() 

# replace first max with NA then find the now-remaining max largest as answer2
# glue together as whichever vector place (colnum) is smaller, then the larger colnum 
