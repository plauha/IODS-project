# Patrik Lauha
# 11.12.2023
# A script for preprocessing BPRS and RATS datasets

library(readr)
library(stringr)
library(tidyr)

# read in the data sets with read_delim
bprs <- read_delim("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", delim=' ')
rats <- read_delim("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", delim='\t')
# fix last column in rats data set
rats_colnames = colnames(rats)
rats[c('WD64', 'last')] = str_split_fixed(rats$WD64, '\t', 2)
rats = rats[2:ncol(rats)]
colnames(rats) = rats_colnames

View(bprs)
summary(bprs)
View(rats)
summary(rats)

# Convert to factors
rats$Group = as.factor(rats$Group)
rats$ID = as.factor(rats$ID)
bprs$treatment = as.factor(bprs$treatment)
bprs$subject = as.factor(bprs$subject)

# Convert to long format
bprs_long <- gather(bprs, week, measurement, week0:week8, factor_key=TRUE)
rats_long <- gather(rats, Time, measurement, WD1:WD64, factor_key=TRUE)

summary(bprs_long)
summary(rats_long)
# We have moved the measurements from different time points under the same variable and added 
# the time of the measurement as a new variable to the data

write_csv(rats_long, 'data/rats.csv')
write_csv(bprs_long, 'data/bprs.csv')

