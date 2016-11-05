# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
class <- read.table(text=
"C_name F_key
class1 f1
class2 f2
class3 f2
class4 f3
class5 f3
class6 f3
class7 f4
class8 f4
class9 f1", header=T)

enroll <- read.table(text=
"S_key C_name
S1 class1
S1 class2
S1 class3
S2 class1
S2 class4
S2 class7
S3 class2
S3 class4
S3 class5
S4 class1
S4 class2
S4 class4
S4 class5
S5 class3
S5 class4
S5 class6
S5 class7
S6 class3
S6 class4
S6 class9
S7 class1
S7 class3
S7 class5
S7 class6
S8 class2
S8 class3
S8 class4
S8 class5
S8 class6
S8 class8",header=T)

faculty <- read.table(text=
"F_key F_name
f1 faculty1
f2 faculty2
f3 faculty3
f4 faculty4",header=T)

write.csv(class, "sql/class.csv", row.names=FALSE)
write.csv(enroll, "sql/enroll.csv", row.names=FALSE)
write.csv(faculty, "sql/faculty.csv", row.names=FALSE)

enroll <- read.csv("sql/enroll.csv", check.names = FALSE)
fctr.cols <- sapply(enroll, is.factor)
int.cols <- sapply(enroll, is.integer)
enroll[, fctr.cols] <- sapply(enroll[, fctr.cols], as.character)
enroll[, int.cols] <- sapply(enroll[, int.cols], as.numeric)
save(enroll, file = "sql/enroll.rdata")

faculty <- read.csv("sql/faculty.csv", check.names = FALSE)
fctr.cols <- sapply(faculty, is.factor)
int.cols <- sapply(faculty, is.integer)
faculty[, fctr.cols] <- sapply(faculty[, fctr.cols], as.character)
faculty[, int.cols] <- sapply(faculty[, int.cols], as.numeric)
save(faculty, file = "sql/faculty.rdata")

class <- read.csv("sql/class.csv", check.names = FALSE)
fctr.cols <- sapply(class, is.factor)
int.cols <- sapply(class, is.integer)
class[, fctr.cols] <- sapply(class[, fctr.cols], as.character)
class[, int.cols] <- sapply(class[, int.cols], as.numeric)
save(class, file = "sql/class.rdata")

# original table from sqlsynthesizer is not consistent with the textbook
# 5.1.6
inner_join(class, enroll) %>% 
inner_join(faculty) %>% 
group_by(F_name) %>% 
summarise(n = n()) %>% 
#filter (n < 5 | n == 5) %>% # the table from sqlsynthesizer would require this filter instead
filter (n < 5) %>% 
select(F_name)