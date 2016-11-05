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
"S_key age level
S1 19 SO
S2 19 JR
S3 19 JR
S4 20 SO
S5 20 JR
S6 20 SO
S7 21 SO
S8 21 SO
S9 21 SR
S10 22 SR", header=T)

write.csv(student, "sql/student.csv", row.names=FALSE)

student <- read.csv("sql/student.csv", check.names = FALSE)
fctr.cols <- sapply(student, is.factor)
int.cols <- sapply(student, is.integer)
student[, fctr.cols] <- sapply(student[, fctr.cols], as.character)
student[, int.cols] <- sapply(student[, int.cols], as.numeric)
save(student, file = "sql/student.rdata")

# 5.1.12
#df1=student %>% group_by(age,level) %>% summarise(n = n()) %>% group_by(age) %>% summarise(n = max(n))
#df2=student %>% group_by(age,level) %>% summarise(n = n())
#inner_join(df1,df2) %>% select(-`n`)

#simplier solution that it works since we never ungroup
student %>% 
group_by(age,level) %>% 
summarise(n = n()) %>% 
filter(n==max(n)) %>% 
select(-n)