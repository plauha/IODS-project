# Patrik Lauha
# 10.11.2023
# A script for preprocessing learning2014 data

library(tidyverse)
data <- read_delim("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", delim='\t', trim_ws=TRUE)
View(data) 

# Data contains 60 variables containing values between 1-5 for 183 observations

data$Attitude = (data$Da+data$Db + data$Dc + data$Dd + data$De + data$Df + data$Dg + data$Dh + data$Di + data$Dj)/10
data$Deep = (data$D03+data$D11+data$D19+data$D27+data$D07+data$D14+data$D22+data$D30+data$D06+data$D15+data$D23+data$D31)/12
data$Stra = (data$ST01+data$ST09+data$ST17+data$ST25+data$ST04+data$ST12+data$ST20+data$ST28)/8
data$Surf = (data$SU02+data$SU10+data$SU18+data$SU26+data$SU05+data$SU13+data$SU21+data$SU29+data$SU08+data$SU16+data$SU24+data$SU32)/12

an_data = data[c('gender','Age','Attitude', 'Deep', 'Stra', 'Surf', 'Points')]
an_data = an_data[an_data['Points']>0,]

getwd()
# Working directory is already correct, but if it wasn't I could fix it by setwd()

write_csv(an_data, 'data/learning2014.csv')

# This is how I would read the data set again
new_data = read_csv('data/learning2014.csv')
str(new_data)
head(new_data)
