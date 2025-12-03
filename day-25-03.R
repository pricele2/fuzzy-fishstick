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

# for string of length Yn
# split into n columns 
# compare digit in index place Y to digit in place Y+1 
# moving to the *left*
# if Y+1 >= Y, replace Y with 0
