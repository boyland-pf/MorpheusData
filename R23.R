# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"custno	1   2   3   
 100	29.85  49.75  146.70 
 100	122.70 49.75  39.80 
 100	0.00   9.95   44.95
", header=T)

write.csv(dat, "data-raw/r23_input1.csv", row.names=FALSE)

df_out = gather(dat, month, spent, -`custno`) %>%
group_by(custno) %>%
summarise(totalspent = sum(spent)) %>%
arrange(desc(totalspent))

write.csv(df_out, "data-raw/r23_output1.csv", row.names=FALSE)

r23_output1 <- read.csv("data-raw/r23_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r23_output1, is.factor)
int.cols <- sapply(r23_output1, is.integer)

r23_output1[, fctr.cols] <- sapply(r23_output1[, fctr.cols], as.character)
r23_output1[, int.cols] <- sapply(r23_output1[, int.cols], as.numeric)
save(r23_output1, file = "data/r23_output1.rdata")

r23_input1 <- read.csv("data-raw/r23_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r23_input1, is.factor)
int.cols <- sapply(r23_input1, is.integer)

r23_input1[, fctr.cols] <- sapply(r23_input1[, fctr.cols], as.character)
r23_input1[, int.cols] <- sapply(r23_input1[, int.cols], as.numeric)
save(r23_input1, file = "data/r23_input1.rdata")
