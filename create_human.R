# Patrik Lauha
# created 24.11.2023, modified 1.12.2023
# A script for preprocessing data of Human Development Index (HDI).

library(readr)
library(tidyr)
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
#write_csv(human, 'data/human.csv')

summary(human)
# Data contains information of wellbeing and gender equality in 195 countries including for example following variables:
#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate
#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.FM" = Proportion of females with at least secondary education compared to that of males
#"Labo.FM" = Proportion of females in the labour force compared to that of males

human = human[c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")]

human = drop_na(human)

drop = c('Arab States', 'Europe and Central Asia', 'East Asia and the Pacific', 'Latin America and the Caribbean', 'South Asia', 'Sub-Saharan Africa', 'World')
human = human[!human$Country %in% drop,]

# save data
write_csv(human, 'data/human.csv')
