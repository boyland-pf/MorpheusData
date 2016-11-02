# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"V51  Hour Group
1 02:00:00   SBT
1 08:00:00   SBS
9 08:00:00   SBS
4 18:00:00   SBS
2 06:00:00   SBI
6 11:00:00   SBT
4 18:00:00   SBS
6 10:00:00   SBI
", header=T)

write.csv(dat, "data-raw/p77_input1.csv", row.names=FALSE)

df_out = dat %>% 
    filter(Group=='SBS') %>% 
    group_by(Hour) %>%
    summarise(sum = sum(V51)) %>% 
    select(-Hour)

write.csv(df_out, "data-raw/p77_output1.csv", row.names=FALSE)

p77_output1 <- read.csv("data-raw/p77_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p77_output1, is.factor)
int.cols <- sapply(p77_output1, is.integer)

p77_output1[, fctr.cols] <- sapply(p77_output1[, fctr.cols], as.character)
p77_output1[, int.cols] <- sapply(p77_output1[, int.cols], as.numeric)
save(p77_output1, file = "data/p77_output1.rdata")

p77_input1 <- read.csv("data-raw/p77_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p77_input1, is.factor)
int.cols <- sapply(p77_input1, is.integer)

p77_input1[, fctr.cols] <- sapply(p77_input1[, fctr.cols], as.character)
p77_input1[, int.cols] <- sapply(p77_input1[, int.cols], as.numeric)
save(p77_input1, file = "data/p77_input1.rdata")
