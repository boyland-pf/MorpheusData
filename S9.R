# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
class <- read.table(text=
"ID_class ID_key room
C1 F1 R101
C2 F1 R128
C3 F1 R103
C4 F2 R103
C5 F3 R101
C6 F4 R128
C7 F2 R101
C9 F5 R128
C10 F6 R102
C11 F7 R128
C12 F7 R103
C13 F8 R102
C14 F8 R128
C15 F8 R128
C16 F4 R128
C17 F5 R128
C18 F5 R128
C19 F9 R128", header=T)

faculty <- read.table(text=
"ID_key fname
F1 teach1
F2 teach2
F3 teach3
F4 teach4
F5 teach5
F6 teach6
F7 teach7
F8 teach8
F9 teach9", header=T)

# write.csv(faculty, "sql/faculty.csv", row.names=FALSE)
# write.csv(class, "sql/class.csv", row.names=FALSE)

# faculty <- read.csv("sql/faculty.csv", check.names = FALSE)
# fctr.cols <- sapply(faculty, is.factor)
# int.cols <- sapply(faculty, is.integer)
# faculty[, fctr.cols] <- sapply(faculty[, fctr.cols], as.character)
# faculty[, int.cols] <- sapply(faculty[, int.cols], as.numeric)
# save(faculty, file = "sql/faculty.rdata")

# class <- read.csv("sql/class.csv", check.names = FALSE)
# fctr.cols <- sapply(class, is.factor)
# int.cols <- sapply(class, is.integer)
# class[, fctr.cols] <- sapply(class[, fctr.cols], as.character)
# class[, int.cols] <- sapply(class[, int.cols], as.numeric)
# save(class, file = "sql/class.rdata")

input=inner_join(faculty,class)
write.csv(input, "data-raw/s9_input1.csv", row.names=FALSE)
s9_input1 <- read.csv("data-raw/s9_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s9_input1, is.factor)
int.cols <- sapply(s9_input1, is.integer)
s9_input1[, fctr.cols] <- sapply(s9_input1[, fctr.cols], as.character)
s9_input1[, int.cols] <- sapply(s9_input1[, int.cols], as.numeric)
save(s9_input1, file = "data/s9_input1.rdata")

df1=inner_join(faculty,class) %>% filter(room == "R128") %>% group_by(fname) %>% summarise (n = n())
df2=inner_join(faculty,class) %>% group_by(fname) %>% summarise (n = n())
output=inner_join(df1,df2)
write.csv(output, "data-raw/s9_output1.csv", row.names=FALSE)
s9_output1 <- read.csv("data-raw/s9_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s9_output1, is.factor)
int.cols <- sapply(s9_output1, is.integer)
s9_output1[, fctr.cols] <- sapply(s9_output1[, fctr.cols], as.character)
s9_output1[, int.cols] <- sapply(s9_output1[, int.cols], as.numeric)
save(s9_output1, file = "data/s9_output1.rdata")


# 5.1.9
df1=inner_join(faculty,class) %>% filter(room == "R128") %>% group_by(fname) %>% summarise (n = n())
df2=inner_join(faculty,class) %>% group_by(fname) %>% summarise (n = n())
inner_join(df1,df2)