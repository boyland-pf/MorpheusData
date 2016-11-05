# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
enrolled <- read.table(text=
"S_key cname
S1 class1
S1 class2
S2 class1
S2 class2
S2 class3
S3 class1
S4 class3
S4 class2
S5 class1
S5 class2
S5 class4
S6 class3
S6 class4", header=T)

student <- read.table(text=
"S_key sname
S1 stu1
S2 stu2
S3 stu3
S4 stu4
S5 stu5
S6 stu6", header=T)

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

# 5.1.10
inner_join(student,enrolled) %>% 
group_by(sname) %>% 
summarise (n = n()) %>% 
filter(n == max(n)) %>% 
select(sname)