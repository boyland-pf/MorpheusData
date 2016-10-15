# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
df <- data.frame(month=rep(1:3,2),
                 student=rep(c("Amy", "Bob"), each=3),
                 A=c(9, 7, 6, 8, 6, 9),
                 B=c(6, 7, 8, 5, 6, 7))

write.csv(df, "data-raw/p2_input1.csv", row.names=FALSE)

df_out = df %>% 
  gather(variable, value, -(month:student)) %>%
  unite(temp, student, variable) %>%
  spread(temp, value)

write.csv(df_out, "data-raw/p2_output1.csv", row.names=FALSE)

p2_output1 <- read.csv("data-raw/p2_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p2_output1, is.factor)
int.cols <- sapply(p2_output1, is.integer)

p2_output1[, fctr.cols] <- sapply(p2_output1[, fctr.cols], as.character)
p2_output1[, int.cols] <- sapply(p2_output1[, int.cols], as.numeric)
save(p2_output1, file = "data/p2_output1.rdata")

p2_input1 <- read.csv("data-raw/p2_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p2_input1, is.factor)
int.cols <- sapply(p2_input1, is.integer)

p2_input1[, fctr.cols] <- sapply(p2_input1[, fctr.cols], as.character)
p2_input1[, int.cols] <- sapply(p2_input1[, int.cols], as.numeric)
save(p2_input1, file = "data/p2_input1.rdata")


