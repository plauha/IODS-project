# Patrik Lauha
# 16.11.2023
# A script for preprocessing alcohol consumption data

# read the data
library(readr)
student_mat <- read_delim("data/student-mat.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(student_mat)
student_por <- read_delim("data/student-por.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(student_por)
# The data sets contain information (33 variables) of students of a 
# math course (395 students) and a portuguese course (649 students)

# select column names to merge by
column_names = colnames(student_mat)
column_names = column_names[! column_names %in% c('failures', 'paid', 'absences', 'G1', 'G2', 'G3')]
# merge datasets
student_all = merge(student_mat, student_por, by=column_names, all=FALSE)
# The resulting data set contains 39 variables from 370 students 
# (27 backround variables + 6 course specific variables from both courses)

# there are no duplicate recordings in the dataset after using merge
student_all[!duplicated(student_all[column_names]),]

# Calculate average alcohol consumption
student_all$alc_use = (student_all$Dalc + student_all$Walc)/2
student_all$high_use = student_all$alc_use > 2 

View(student_all)
# everything seems to be in order, data contains 370 students and new columns work as expected

# save data
write_csv(student_all, 'data/student_all.csv')