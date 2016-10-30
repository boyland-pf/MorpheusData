# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1

dat <- read.table(text=
"Id Group Var1 Var2
1     A good   10
2     A bad    7
3     A  bad    9
4     B good    6
5     B good    8
6     B  bad    8
", header=T)

write.csv(dat, "data-raw/p17_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(Group, Var1) %>%
    summarise(Total = sum(Var2)) %>%
    spread(Var1,Total) %>%
    filter(good>6)

write.csv(df_out, "data-raw/p17_output1.csv", row.names=FALSE)

p17_output1 <- read.csv("data-raw/p17_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p17_output1, is.factor)
int.cols <- sapply(p17_output1, is.integer)

p17_output1[, fctr.cols] <- sapply(p17_output1[, fctr.cols], as.character)
p17_output1[, int.cols] <- sapply(p17_output1[, int.cols], as.numeric)
save(p17_output1, file = "data/p17_output1.rdata")

p17_input1 <- read.csv("data-raw/p17_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p17_input1, is.factor)
int.cols <- sapply(p17_input1, is.integer)

p17_input1[, fctr.cols] <- sapply(p17_input1[, fctr.cols], as.character)
p17_input1[, int.cols] <- sapply(p17_input1[, int.cols], as.numeric)
save(p17_input1, file = "data/p17_input1.rdata")
