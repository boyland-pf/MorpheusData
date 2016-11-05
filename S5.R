# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
class <- read.table(text=
"C_name F_key Room
C1 F1 R101
C2 F1 R102
C3 F1 R103
C4 F2 R103
C5 F3 R101
C6 F4 R101
C7 F2 R101
C8 F4 R102
C9 F4 R103
C10 F5 R101
C11 F5 R102
C12 F5 R103", header=T)

faculty <- read.table(text=
"F_key F_name
F1 teach1
F2 teach2
F3 teach3
F4 teach4
F5 teach5",header=T)

write.csv(class, "sql/class.csv", row.names=FALSE)
write.csv(faculty, "sql/faculty.csv", row.names=FALSE)


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

# 5.1.5
# how to determine 3 = count(distinct(class,Room))
# assumes that each faculty has a different name
#inner_join(class,faculty) %>% 
#group_by(F_name) %>% 
#summarise(n = n()) %>% 
#filter (n == as.numeric(count(distinct(class,Room)))) %>% 
#select(F_name)

# without the crazy filter but assuming that n() will be named n
#inner_join(class,faculty) %>% 
#group_by(F_name) %>% 
#summarise(n = n()) %>%
#inner_join(count(distinct(class,Room))) %>% 
#select(F_name)

# if you assume some teacher teaches on every class then you could use the following query
inner_join(class,faculty) %>% 
group_by(F_name) %>% 
summarise(n = n()) %>% 
filter(n == max(n)) %>% 
select(F_name)

# if we use the constants from the current table for the filter we can generate this solution
# inner_join(class,faculty) %>% 
# group_by(F_name) %>% 
# summarise(n = n()) %>% 
# filter(n == 3) %>% 
# select(F_name)
