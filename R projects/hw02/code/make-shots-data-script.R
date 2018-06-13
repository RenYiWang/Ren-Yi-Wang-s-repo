# ===================================================================
# Title: make-shots-data-script
# Description: data preparation and export summaries
# Input(s): .csv files for nba players
# Output(s): .txt files for summary and a .csv file for shots data
# Author(s): Ren Yi Wang
# Date: 03-06-2018
# ===================================================================

# 3) Data Preparation

# make-shots-data-script.R
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)

# Add a column name to each imported data frame,
# that contains the name of the corresponding player
library(dplyr)
iguodala <- mutate(iguodala, name = rep('Andre Iguodala', nrow(iguodala)))
green <- mutate(green, name = rep('Graymond Green', nrow(green)))
durant <- mutate(durant, name = rep('Kevin Durant', nrow(durant)))
thompson <- mutate(thompson, name = rep('Klay Thompson', nrow(thompson)))
curry <- mutate(curry, name = rep('Stephen Curry', nrow(curry)))

# Change the original values of shot_made_flag to more descriptive values: replace "n"
# with "missed shot", and "y" with "made shot".
iguodala[iguodala$shot_made_flag == 'n', ]$shot_made_flag = 'missed shot'
iguodala[iguodala$shot_made_flag == 'y', ]$shot_made_flag = 'made shot'
green[green$shot_made_flag == 'n', ]$shot_made_flag = 'missed shot'
green[green$shot_made_flag == 'y', ]$shot_made_flag = 'made shot'
durant[durant$shot_made_flag == 'n', ]$shot_made_flag = 'missed shot'
durant[durant$shot_made_flag == 'y', ]$shot_made_flag = 'made shot'
thompson[thompson$shot_made_flag == 'n', ]$shot_made_flag = 'missed shot'
thompson[thompson$shot_made_flag == 'y', ]$shot_made_flag = 'made shot'
curry[curry$shot_made_flag == 'n', ]$shot_made_flag = 'missed shot'
curry[curry$shot_made_flag == 'y', ]$shot_made_flag = 'made shot'

# Add a column minute that contains the minute number where a shot occurred.
iguodala <- mutate(iguodala, minute = 12*period - minutes_remaining)
green <- mutate(green, minute = 12*period - minutes_remaining)
durant <- mutate(durant, minute = 12*period - minutes_remaining)
thompson <- mutate(thompson, minute = 12*period - minutes_remaining)
curry <- mutate(curry, minute = 12*period - minutes_remaining)

# Use sink() to send the summary() output of each imported data
# frame into individuals text files
sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = '../output/klay-thompson-summary.txt')
summary(thompson)
sink()

sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()

# Use the row binding function rbind() to stack the tables
# into one single data frame
gsw <- rbind(iguodala, green, durant, thompson, curry)

# Export (i.e. write) the assembled table as a CSV file shots-data.csv
# inside the folder data/. Use a relative path for this operation.
write.csv(gsw, file = '../data/shots-data.csv', row.names = FALSE)

# Use sink() to send the summary() output of the assembled table. 
# Send this output to a text file named shots-data-summary.txt
# inside the output/ folder
sink(file = '../output/shots-data-summary.txt')
summary(gsw)
sink()














