# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 28
dat <- read.table(text=
"ID    T    P.1 P.2
1   24.3    10.2    5.5
2   23.4    10.4    5.7
", header=T)

train <- read.table(text=
"id prod clnt    order
1   8    5 6.912931
3   2    6 5.119676
4   7    1 7.472010
2   8    4 7.345583
5   8    5 9.412050",
header=T)

test <- read.table(text=
"id prod clnt    order
3    2    6 5.119676
5    8    5 9.412050",
header=T)

write.csv(train, "data-raw/r27_input1.csv", row.names=FALSE)
write.csv(test, "data-raw/r27_input2.csv", row.names=FALSE)

newtrain <- select(train, 2:4)
newtest <- select(test, 1:3)
x <- dplyr::inner_join(newtest, newtrain)
y <- dplyr::group_by(x, prod, clnt)
df_out <- dplyr::summarise(y, mean.order=mean(order))

write.csv(df_out, "data-raw/r27_output1.csv", row.names=FALSE)

r27_output1 <- read.csv("data-raw/r27_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r27_output1, is.factor)
int.cols <- sapply(r27_output1, is.integer)

r27_output1[, fctr.cols] <- sapply(r27_output1[, fctr.cols], as.character)
r27_output1[, int.cols] <- sapply(r27_output1[, int.cols], as.numeric)
save(r27_output1, file = "data/r27_output1.rdata")

r27_input1 <- read.csv("data-raw/r27_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r27_input1, is.factor)
int.cols <- sapply(r27_input1, is.integer)

r27_input1[, fctr.cols] <- sapply(r27_input1[, fctr.cols], as.character)
r27_input1[, int.cols] <- sapply(r27_input1[, int.cols], as.numeric)
save(r27_input1, file = "data/r27_input1.rdata")

r27_input2 <- read.csv("data-raw/r27_input2.csv", check.names = FALSE)
fctr.cols <- sapply(r27_input2, is.factor)
int.cols <- sapply(r27_input2, is.integer)

r27_input2[, fctr.cols] <- sapply(r27_input2[, fctr.cols], as.character)
r27_input2[, int.cols] <- sapply(r27_input2[, int.cols], as.numeric)
save(r27_input2, file = "data/r27_input2.rdata")
