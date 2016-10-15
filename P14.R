# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
df1 <- structure(list(Name = c("A", "B", "C"), Total = c(43L, 56L, 98L
)), .Names = c("Name", "Total"), class = "data.frame", row.names = c(NA, 
-3L))

df2 <- structure(list(Name = c("A", "B", "C"), col1 = c(2L, 0L, 3L), 
col2 = c(3L, 4L, 0L), col3 = c(4L, 0L, 0L), col4 = c(0L, 
0L, 3L)), .Names = c("Name", "col1", "col2", "col3", "col4"
), class = "data.frame", row.names = c(NA, -3L))

write.csv(df1, "data-raw/p14_input1.csv", row.names=FALSE)
write.csv(df2, "data-raw/p14_input2.csv", row.names=FALSE)

df_out = df2 %>%
inner_join(df1) %>%
gather(variable, value, -Name, -Total) %>%
mutate(value = value/Total) %>%
spread(variable, value)

write.csv(df_out, "data-raw/p14_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p14_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p14_output1.rdata")

input1 <- read.csv("data-raw/p14_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p14_input1.rdata")


input2 <- read.csv("data-raw/p14_input2.csv", check.names = FALSE)
fctr.cols <- sapply(input2, is.factor)
int.cols <- sapply(input2, is.integer)

input2[, fctr.cols] <- sapply(input2[, fctr.cols], as.character)
input2[, int.cols] <- sapply(input2[, int.cols], as.numeric)
save(input2, file = "data/p14_input2.rdata")
