# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"custno  1   2      
100      29.85  49.75  
100      122.70 49.75 
100      0.00   9.95 
", header=T)

write.csv(dat, "data-raw/p23_input1.csv", row.names=FALSE)

df_out = gather(dat, month, spent, 2:3) %>%
group_by(custno) %>%
summarise(totalspent = sum(spent)) %>%
arrange(desc(totalspent))

write.csv(df_out, "data-raw/p23_output1.csv", row.names=FALSE)

p23_output1 <- read.csv("data-raw/p23_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p23_output1, is.factor)
int.cols <- sapply(p23_output1, is.integer)

p23_output1[, fctr.cols] <- sapply(p23_output1[, fctr.cols], as.character)
p23_output1[, int.cols] <- sapply(p23_output1[, int.cols], as.numeric)
save(p23_output1, file = "data/p23_output1.rdata")

p23_input1 <- read.csv("data-raw/p23_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p23_input1, is.factor)
int.cols <- sapply(p23_input1, is.integer)

p23_input1[, fctr.cols] <- sapply(p23_input1[, fctr.cols], as.character)
p23_input1[, int.cols] <- sapply(p23_input1[, int.cols], as.numeric)
save(p23_input1, file = "data/p23_input1.rdata")
