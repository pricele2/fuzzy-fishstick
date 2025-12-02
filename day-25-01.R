# Day 01 of Advent of Code 2025 ----
# https://adventofcode.com/2025/day/1

## Salient constraints
# The safe has a dial with only an arrow on it; around the dial are the numbers 0 through 99 in order. As you turn the dial, it makes a small click noise as it reaches each number.

# Because the dial is a circle, turning the dial left from 0 one click makes it point at 99. Similarly, turning the dial right from 99 one click makes it point at 0.

# The actual password is the number of times the dial is left pointing at 0 after any rotation in the sequence.

## Replicate the example ---- 
## By hand
v0 = 50 # Start at 50
v1 = v0 + -68
v2 = v1 + -30
v3 = v2 + +48
v4 = v3 + -5
v5 = v4 + +60
v6 = v5 + -55
v7 = v6 + -1
v8 = v7 + -99 # which equals 0
v8 = 0
v9 = v8 + +14
v10 = v9 + -82

# put these in as a text file, check readLines fn
input-01 = "
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"

## With loop, check modulo function 
library("stringr")
# input = readLines("~/R/advent-of-code/input-01-mre.R")
input = readLines("~/R/advent-of-code/input-01-pt1.R")

direction = str_sub(input, 1, 1)
value = as.integer(str_sub(input, 2, 1000))

zeros = 0
position = 50
i = 1 

for (i in seq_along(input)) {
  if(direction[i] == "L") {
    position = position - value[i]
  }
  if(direction[i] == "R") {
    position = position + value[i]
  }
  
  position = position %% 100 # using modulo per https://hyperskill.org/university/r-language/modulo-operation-in-r#:~:text=When%20you%20use%20the%20modulo,solving%20cyclic%20problems%20like%20calendars.
  
  if (position == 0) {
    zeros = zeros + 1
    }
}

zeros # 1059 *YAY CORRECT 