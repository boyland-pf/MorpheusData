# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
id_class_5_1_3 <- read.table(text=
"ID_key Room
C1 R102
C2 R120
C3 R128
C4 R127
C5 R131
C6 R128
C7 R130
C8 R130
C9 R128
C10 R102
C11 R120
C12 R131
C13 R127
C14 R131", header=T)

id_enroll_5_1_3 <- read.table(text=
"ID_key_student ID_key
S1 C1
S1 C2
S2 C1
S2 C3
S2 C4
S3 C2
S3 C4
S4 C1
S4 C5
S5 C5
S6 C1
S6 C5
S7 C2
S7 C3
S7 C5
S8 C1
S9 C5
S10 C5
S10 C6
S9 C7
S8 C8
S8 C9
S10 C10
S1 C11
S2 C11
S3 C11
S4 C11
S5 C11
S7 C12
S8 C12
S7 C13
S1 C13
S2 C13
S4 C13
S9 C14
S10 C14
S5 C14
S6 C14",header=T)

write.csv(id_class_5_1_3, "sql/id_class_5_1_3.csv", row.names=FALSE)
write.csv(id_enroll_5_1_3, "sql/id_enroll_5_1_3.csv", row.names=FALSE)

id_class_5_1_3 <- read.csv("sql/id_class_5_1_3.csv", check.names = FALSE)
fctr.cols <- sapply(id_class_5_1_3, is.factor)
int.cols <- sapply(id_class_5_1_3, is.integer)
id_class_5_1_3[, fctr.cols] <- sapply(id_class_5_1_3[, fctr.cols], as.character)
id_class_5_1_3[, int.cols] <- sapply(id_class_5_1_3[, int.cols], as.numeric)
save(id_class_5_1_3, file = "sql/id_class_5_1_3.rdata")

id_enroll_5_1_3 <- read.csv("sql/id_enroll_5_1_3.csv", check.names = FALSE)
fctr.cols <- sapply(id_enroll_5_1_3, is.factor)
int.cols <- sapply(id_enroll_5_1_3, is.integer)
id_enroll_5_1_3[, fctr.cols] <- sapply(id_enroll_5_1_3[, fctr.cols], as.character)
id_enroll_5_1_3[, int.cols] <- sapply(id_enroll_5_1_3[, int.cols], as.numeric)
save(id_enroll_5_1_3, file = "sql/id_enroll_5_1_3.rdata")

# 5.1.3
#sol1 <- group_by(id_enroll_5_1_3,ID_key) %>% 
#summarize(n = n()) %>% 
#inner_join(id_class_5_1_3) %>% 
#filter(Room == "R128" | n > 4) %>% 
#select(ID_key)

# alternative -- only works because the same class is always taught in the same room
inner_join(id_class_5_1_3,id_enroll_5_1_3) %>% 
group_by(ID_key,Room) %>% 
summarize(n = n()) %>% 
filter(Room == "R128" | n > 4) %>% select(ID_key)
