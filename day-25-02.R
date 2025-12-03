# Day 02 of Advent of Code 2025 ----
# https://adventofcode.com/2025/day/2

# Salient constraints ----

# The ranges are separated by commas (,); each range gives its first ID and last ID separated by a dash (-).

# Find the invalid IDs by looking for any ID which is made only of some sequence of digits repeated twice. So, 55 (5 twice), 6464 (64 twice), and 123123 (123 twice) would all be invalid IDs.

# Replicate example 
library("stringr")
library("dplyr")
library("tidyr")

inp1 = readLines("~/R/advent-of-code/input-02-mre.R") |> as_tibble() |> rename(both = value)
# inp1 = readLines("~/R/advent-of-code/input-02.R") |> as_tibble() |> rename(both = value)

inp2 = str_split_1(inp1$both, ",") |> as_tibble() |> rename(pairs = value)

# split into low and high bookends 
inp3 = separate_wider_delim(inp2, pairs, delim = "-", names = c("lo_end", "hi_end")) |> 
  # mutate(lo_end = as.integer(lo_end), hi_end = as.integer(hi_end)) |> 
  mutate(lo_end = as.numeric(lo_end), hi_end = as.numeric(hi_end)) |> 
  arrange(lo_end) 

# get dimensions first (unnecessary step)
inp3$range_n = inp3$hi_end - inp3$lo_end
sum(inp3$range_n) # 95 on MRE, 2489730 on input, plus 38 originals

# create sequence of new ID tags
inp4 = inp3 |> 
  rowwise() |> 
  mutate(new = list(seq(lo_end, hi_end, by = 1))) |> 
  as_tibble()

# reshape into single vector 
inp5 = unnest_longer(inp4, new, values_to = "tags_int") |> 
  select(-c(ends_with("_end"))) |> 
  mutate(tags_str = as.character(tags_int))  |> 
  mutate(tag_len = str_length(tags_str)) 

# drop every ID tag with an odd length since 
inp6 = inp5 |> 
  mutate(keep_drop = 
    case_when(
      tag_len %% 2 == 0 ~ "keep",
      tag_len %% 2 != 0 ~ "drop",
     TRUE ~ "NA")
    ) |> 
  filter(keep_drop == "keep") |> 
  select(-c("keep_drop"))

# use str_len to find halfway point, split and compare strings
# str_sub("fruits", (str_length("fruits")/2)) is identical to str_sub("fruits", 3)

inp7 = inp6 |> 
  mutate(
    part1 = str_sub(tags_str, 1, (tag_len/2)),
    part2 = str_sub(tags_str, -(tag_len/2)),
    ) |> 
  mutate(test = str_equal(part1, part2)) |> 
  filter(test == TRUE)

sum_invalid_ids = cumsum(inp7$tags_int) #1227775554
print(max(sum_invalid_ids)) ## YES IT WORKED ! 

# run it again but with input-02.R
# Use as.numeric instead of as.integer otherwise you lose 2 values to NA
# Answer: 13108371860

# Part Two ----
# https://adventofcode.com/2025/day/2#part2
# The clerk quickly discovers that there are still invalid IDs in the ranges in your list. Maybe the young Elf was doing other silly patterns as well? Now, an ID is invalid if it is made only of some sequence of digits repeated at least twice. So, 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs.

# Use inp5 from above 
min(inp5$tags_int) 
max(inp5$tags_int)
max(inp5$tag_len)
rm(inp6)
rm(inp7)

## All these are prime factors 
# library("primes")
install.packages("numbers")
library(numbers)
# primeFactors(inp5$tag_len[106])

ftors = as_tibble(inp5$tag_len) |> unique() |> 
  rowwise() |> 
  mutate(ftors = list(primeFactors(value))) |> 
  as_tibble()
  
  ftors2 = unnest(ftors, ftors, keep_empty = TRUE) 
  ftvalue = ftors2$value |> as_tibble()
  ftftors = ftors2$ftors |> as_tibble()
  ftone = as_tibble(1)
ftboth = bind_rows(ftvalue, ftftors, ftone) |> unique()
  rm(ftors, ftors2, ftvalue, ftftors, ftone)

# for each ftboth[i], 
# if tags_len %% [i] == 0 ~ "keep"

  # then compare  
#   part1 = str_sub(tags_str, 1, (tag_len/[i])),
#   part2 = str_sub(tags_str, -(tag_len/[i]))
#   
#   mutate(test = str_equal(part1, part2)) |> 
#     filter(test == TRUE)
  