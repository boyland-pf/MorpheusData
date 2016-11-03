# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 96
dat <- read.table(text=
"
x
A
A
B
C
D
", header=T)

map <- read.table(text=
"
x y
A yes
B no
C yes
D no
E no
", header=T)

write.csv(dat, "data-raw/p96_input1.csv", row.names=FALSE)
write.csv(map, "data-raw/p96_input2.csv", row.names=FALSE)

df_out = filter(map, y == "yes") %>% select(x) %>% inner_join(dat)

write.csv(df_out, "data-raw/p96_output1.csv", row.names=FALSE)

p96_output1 <- read.csv("data-raw/p96_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p96_output1, is.factor)
int.cols <- sapply(p96_output1, is.integer)

p96_output1[, fctr.cols] <- sapply(p96_output1[, fctr.cols], as.character)
p96_output1[, int.cols] <- sapply(p96_output1[, int.cols], as.numeric)
save(p96_output1, file = "data/p96_output1.rdata")

p96_input1 <- read.csv("data-raw/p96_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p96_input1, is.factor)
int.cols <- sapply(p96_input1, is.integer)

p96_input1[, fctr.cols] <- sapply(p96_input1[, fctr.cols], as.character)
p96_input1[, int.cols] <- sapply(p96_input1[, int.cols], as.numeric)
save(p96_input1, file = "data/p96_input1.rdata")


p96_input2 <- read.csv("data-raw/p96_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p96_input2, is.factor)
int.cols <- sapply(p96_input2, is.integer)

p96_input2[, fctr.cols] <- sapply(p96_input2[, fctr.cols], as.character)
p96_input2[, int.cols] <- sapply(p96_input2[, int.cols], as.numeric)
save(p96_input2, file = "data/p96_input2.rdata")
