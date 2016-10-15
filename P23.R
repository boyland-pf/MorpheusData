# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"custno  TrainingType    TrainingDate    1   2   3   
100     Presentation    2013-11-26    29.85  49.75  146.70 
100     Presentation    2014-02-25    122.70 49.75  39.80 
100     Training        2013-03-06    0.00   9.95   44.95
", header=T)

write.csv(dat, "data-raw/p23_input1.csv", row.names=FALSE)

df_out = gather(dat, month, spent, 4:6) %>%
group_by(custno) %>%
summarise(totalspent = sum(spent)) %>%
arrange(desc(totalspent))

write.csv(df_out, "data-raw/p23_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p23_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p23_output1.rdata")

input1 <- read.csv("data-raw/p23_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p23_input1.rdata")
