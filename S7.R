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

write.csv(student, "sql/student.csv", row.names=FALSE)


student <- read.csv("sql/student.csv", check.names = FALSE)
fctr.cols <- sapply(student, is.factor)
int.cols <- sapply(student, is.integer)
student[, fctr.cols] <- sapply(student[, fctr.cols], as.character)
student[, int.cols] <- sapply(student[, int.cols], as.numeric)
save(student, file = "sql/student.rdata")

# 5.1.7
student %>% group_by(level) %>% summarize(average=mean(age))