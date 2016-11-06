# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
enrolled <- read.table(text=
"S_key C_name
S1 class2
S2 class1
S4 class2
S4 class4
S5 class4
S7 class5
S7 class1
S8 class4
S10 class5", header=T)

student <- read.table(text=
"S_key S_name
S1 SN1
S2 SN2
S3 SN3
S4 SN4
S5 SN5
S6 SN6
S7 SN7
S8 SN8
S9 SN9
S10 SN10", header=T)

write.csv(enrolled, "sql/enrolled.csv", row.names=FALSE)
write.csv(student, "sql/student.csv", row.names=FALSE)

enrolled <- read.csv("sql/enrolled.csv", check.names = FALSE)
fctr.cols <- sapply(enrolled, is.factor)
int.cols <- sapply(enrolled, is.integer)
enrolled[, fctr.cols] <- sapply(enrolled[, fctr.cols], as.character)
enrolled[, int.cols] <- sapply(enrolled[, int.cols], as.numeric)
save(enrolled, file = "sql/enrolled.rdata")

student <- read.csv("sql/student.csv", check.names = FALSE)
fctr.cols <- sapply(student, is.factor)
int.cols <- sapply(student, is.integer)
student[, fctr.cols] <- sapply(student[, fctr.cols], as.character)
student[, int.cols] <- sapply(student[, int.cols], as.numeric)
save(student, file = "sql/student.rdata")

# 5.1.11
#full_join(enrolled,student) %>% filter(is.na(C_name)) %>% select(S_name)

# does not use full_join or filter by is.na but uses setdiff
df1=inner_join(enrolled,student) %>% select(S_name)
df2=select(student, S_name)
setdiff(df2,df1)

#anti_join(student,enrolled) %>% select(S_name)