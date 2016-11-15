# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)

#############benchmark 26
t1 <- read.table(text=
"  Town Captured Proportion
A      184       0.25
B      243       0.33
", header=T)

t2  <- read.table(text=
"
Town  Species Freq
A funestus  106
A funestus    7
B funestus    5
A  gambiae   38
A  gambiae    6
B  gambiae  234
",header=T)

d1 = t2 %>% group_by(Town,Species) %>% summarise(f=sum(Freq)) %>% spread(Species,f)
df_out = inner_join(t1,d1)

write.csv(df_out, "data-raw/p26_output1.csv", row.names=FALSE)
write.csv(t1, "data-raw/p26_input1.csv", row.names=FALSE)
write.csv(t2, "data-raw/p26_input2.csv", row.names=FALSE)

p26_output1 <- read.csv("data-raw/p26_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p26_output1, is.factor)
int.cols <- sapply(p26_output1, is.integer)

p26_output1[, fctr.cols] <- sapply(p26_output1[, fctr.cols], as.character)
p26_output1[, int.cols] <- sapply(p26_output1[, int.cols], as.numeric)
save(p26_output1, file = "data/p26_output1.rdata")

p26_input1 <- read.csv("data-raw/p26_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p26_input1, is.factor)
int.cols <- sapply(p26_input1, is.integer)

p26_input1[, fctr.cols] <- sapply(p26_input1[, fctr.cols], as.character)
p26_input1[, int.cols] <- sapply(p26_input1[, int.cols], as.numeric)
save(p26_input1, file = "data/p26_input1.rdata")


p26_input2 <- read.csv("data-raw/p26_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p26_input2, is.factor)
int.cols <- sapply(p26_input2, is.integer)

p26_input2[, fctr.cols] <- sapply(p26_input2[, fctr.cols], as.character)
p26_input2[, int.cols] <- sapply(p26_input2[, int.cols], as.numeric)
save(p26_input2, file = "data/p26_input2.rdata")
