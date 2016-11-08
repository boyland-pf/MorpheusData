# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
student <- read.table(text=
"S_key level age
S1 JR 18
S2 SR 24
S3 JR 21
S4 SR 22
S5 JR 18
S6 SO 20
S7 SO 22", header=T)

# write.csv(student, "sql/student.csv", row.names=FALSE)


# student <- read.csv("sql/student.csv", check.names = FALSE)
# fctr.cols <- sapply(student, is.factor)
# int.cols <- sapply(student, is.integer)
# student[, fctr.cols] <- sapply(student[, fctr.cols], as.character)
# student[, int.cols] <- sapply(student[, int.cols], as.numeric)
# save(student, file = "sql/student.rdata")

input=student
write.csv(input, "data-raw/s8_input1.csv", row.names=FALSE)
s8_input1 <- read.csv("data-raw/s8_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s8_input1, is.factor)
int.cols <- sapply(s8_input1, is.integer)
s8_input1[, fctr.cols] <- sapply(s8_input1[, fctr.cols], as.character)
s8_input1[, int.cols] <- sapply(s8_input1[, int.cols], as.numeric)
save(s8_input1, file = "data/s8_input1.rdata")

output=input %>% group_by(level) %>% summarize(average=mean(age)) %>% filter(level != "JR")
write.csv(output, "data-raw/s8_output1.csv", row.names=FALSE)
s8_output1 <- read.csv("data-raw/s8_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s8_output1, is.factor)
int.cols <- sapply(s8_output1, is.integer)
s8_output1[, fctr.cols] <- sapply(s8_output1[, fctr.cols], as.character)
s8_output1[, int.cols] <- sapply(s8_output1[, int.cols], as.numeric)
save(s8_output1, file = "data/s8_output1.rdata")

# 5.1.8
student %>% group_by(level) %>% summarize(average=mean(age)) %>% filter(level != "JR")