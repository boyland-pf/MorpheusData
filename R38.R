# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 39
set.seed(1)
x <- letters[1:10]
df1 <- data.frame(x)
z <- rnorm(20,100,10)
df2 <- data.frame(x,z)

write.csv(df1, "data-raw/r38_input1.csv", row.names=FALSE)
write.csv(df2, "data-raw/r38_input2.csv", row.names=FALSE)

df_out = inner_join(df1, df2) %>% group_by(x) %>% summarise(newZ=sum(z))

write.csv(df_out, "data-raw/r38_output1.csv", row.names=FALSE)

r38_output1 <- read.csv("data-raw/r38_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r38_output1, is.factor)
int.cols <- sapply(r38_output1, is.integer)

r38_output1[, fctr.cols] <- sapply(r38_output1[, fctr.cols], as.character)
r38_output1[, int.cols] <- sapply(r38_output1[, int.cols], as.numeric)
save(r38_output1, file = "data/r38_output1.rdata")

r38_input1 <- read.csv("data-raw/r38_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r38_input1, is.factor)
int.cols <- sapply(r38_input1, is.integer)

r38_input1[, fctr.cols] <- sapply(r38_input1[, fctr.cols], as.character)
r38_input1[, int.cols] <- sapply(r38_input1[, int.cols], as.numeric)
save(r38_input1, file = "data/r38_input1.rdata")

r38_input2 <- read.csv("data-raw/r38_input2.csv", check.names = FALSE)
fctr.cols <- sapply(r38_input2, is.factor)
int.cols <- sapply(r38_input2, is.integer)

r38_input2[, fctr.cols] <- sapply(r38_input2[, fctr.cols], as.character)
r38_input2[, int.cols] <- sapply(r38_input2[, int.cols], as.numeric)
save(r38_input2, file = "data/r38_input2.rdata")
