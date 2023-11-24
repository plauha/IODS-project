# Patrik Lauha
# 24.11.2023
# A script for preprocessing data of Human Development Index (HDI).

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

View(gii) #
summary(gii)
# 10 variables describing gender equality in 195 countries

View(hd)
summary(hd)
# 8 variables describing overall wellbeing in 195 countries

# rename columns
colnames(gii) = c("GII.rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")
colnames(hd) = c("HDI.rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI-HDI")

# introduce new variables
gii$Edu2.FM = gii$Edu2.F / gii$Edu2.M
gii$Labo.FM = gii$Labo.F / gii$Labo.M

# merge data sets
human = merge(gii, hd, by="Country", all=FALSE)

# save data
write_csv(human, 'data/human.csv')