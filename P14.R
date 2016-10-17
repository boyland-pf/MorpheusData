# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
df1 <- structure(list(Name = c("A", "B", "C"), Total = c(43L, 56L, 98L
)), .Names = c("Name", "Total"), class = "data.frame", row.names = c(NA, 
-3L))

df2 <- structure(list(Name = c("A", "B", "C"), col1 = c(2L, 0L, 3L), 
col2 = c(3L, 4L, 0L), col3 = c(4L, 0L, 0L)), .Names = c("Name", "col1", "col2", "col3" 
), class = "data.frame", row.names = c(NA, -3L))

write.csv(df1, "data-raw/p14_input1.csv", row.names=FALSE)
write.csv(df2, "data-raw/p14_input2.csv", row.names=FALSE)

df_out = df2 %>%
inner_join(df1) %>%
gather(variable, value, -Name, -Total) %>%
mutate(ratio = value/Total) %>%
select(-value) %>%
spread(variable, ratio)

write.csv(df_out, "data-raw/p14_output1.csv", row.names=FALSE)

p14_output1 <- read.csv("data-raw/p14_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p14_output1, is.factor)
int.cols <- sapply(p14_output1, is.integer)

p14_output1[, fctr.cols] <- sapply(p14_output1[, fctr.cols], as.character)
p14_output1[, int.cols] <- sapply(p14_output1[, int.cols], as.numeric)
save(p14_output1, file = "data/p14_output1.rdata")

p14_input1 <- read.csv("data-raw/p14_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p14_input1, is.factor)
int.cols <- sapply(p14_input1, is.integer)

p14_input1[, fctr.cols] <- sapply(p14_input1[, fctr.cols], as.character)
p14_input1[, int.cols] <- sapply(p14_input1[, int.cols], as.numeric)
save(p14_input1, file = "data/p14_input1.rdata")


p14_input2 <- read.csv("data-raw/p14_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p14_input2, is.factor)
int.cols <- sapply(p14_input2, is.integer)

p14_input2[, fctr.cols] <- sapply(p14_input2[, fctr.cols], as.character)
p14_input2[, int.cols] <- sapply(p14_input2[, int.cols], as.numeric)
save(p14_input2, file = "data/p14_input2.rdata")
