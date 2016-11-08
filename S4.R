# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
class <- read.table(text=
"C_name meets_at
class1 mon
class2 mon
class3 tue
class4 tue
class5 fri
class6 fri", header=T)

enroll <- read.table(text=
"S_key C_name
S1 class1
S1 class2
S1 class3
S2 class1
S3 class2
S3 class5
S3 class4
S4 class2
S4 class4
S5 class3
S6 class3
S6 class4
S7 class1
S7 class3
S7 class5
S8 class4
S9 class5
S9 class6
S10 class4
S10 class5
S10 class6
S11 class3
S11 class6
S12 class1
S12 class2
S13 class3
S13 class4
S14 class5
S14 class6",header=T)

student <- read.table(text=
"S_key S_name
S1 stu1
S2 stu2
S3 stu3
S4 stu4
S5 stu5
S6 stu6
S7 stu7
S8 stu8
S9 stu9
S10 stu10
S11 stu11
S12 stu12
S13 stu13
S14 stu14",header=T)

# write.csv(class, "sql/class.csv", row.names=FALSE)
# write.csv(enroll, "sql/enroll.csv", row.names=FALSE)
# write.csv(student, "sql/student.csv", row.names=FALSE)


# enroll <- read.csv("sql/enroll.csv", check.names = FALSE)
# fctr.cols <- sapply(enroll, is.factor)
# int.cols <- sapply(enroll, is.integer)
# enroll[, fctr.cols] <- sapply(enroll[, fctr.cols], as.character)
# enroll[, int.cols] <- sapply(enroll[, int.cols], as.numeric)
# save(enroll, file = "sql/enroll.rdata")

# student <- read.csv("sql/student.csv", check.names = FALSE)
# fctr.cols <- sapply(student, is.factor)
# int.cols <- sapply(student, is.integer)
# student[, fctr.cols] <- sapply(student[, fctr.cols], as.character)
# student[, int.cols] <- sapply(student[, int.cols], as.numeric)
# save(student, file = "sql/student.rdata")

# class <- read.csv("sql/class.csv", check.names = FALSE)
# fctr.cols <- sapply(class, is.factor)
# int.cols <- sapply(class, is.integer)
# class[, fctr.cols] <- sapply(class[, fctr.cols], as.character)
# class[, int.cols] <- sapply(class[, int.cols], as.numeric)
# save(class, file = "sql/class.rdata")

input=inner_join(class,enroll) %>% inner_join(student)
write.csv(input, "data-raw/s4_input1.csv", row.names=FALSE)
s4_input1 <- read.csv("data-raw/s4_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s4_input1, is.factor)
int.cols <- sapply(s4_input1, is.integer)
s4_input1[, fctr.cols] <- sapply(s4_input1[, fctr.cols], as.character)
s4_input1[, int.cols] <- sapply(s4_input1[, int.cols], as.numeric)
save(s4_input1, file = "data/s4_input1.rdata")

output=input %>% group_by(S_name,meets_at) %>% summarize(n = n()) %>% filter(n == 2) %>% select(S_name)
write.csv(output, "data-raw/s4_output1.csv", row.names=FALSE)
s4_output1 <- read.csv("data-raw/s4_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s4_output1, is.factor)
int.cols <- sapply(s4_output1, is.integer)
s4_output1[, fctr.cols] <- sapply(s4_output1[, fctr.cols], as.character)
s4_output1[, int.cols] <- sapply(s4_output1[, int.cols], as.numeric)
save(s4_output1, file = "data/s4_output1.rdata")

# 5.1.4
# only works if the student names are different
# needs to use values from the intermediate table
inner_join(class,enroll) %>% 
inner_join(student) %>% 
group_by(S_name,meets_at) %>% 
summarize(n = n()) %>% 
filter(n == 2) %>% 
select(S_name)
