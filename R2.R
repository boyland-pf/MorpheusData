# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
df <- data.frame(month=rep(1:3,2),
                 student=rep(c("Amy", "Bob"), each=3),
                 A=c(9, 7, 6, 8, 6, 9),
                 B=c(6, 7, 8, 5, 6, 7))

write.csv(df, "data-raw/r2_input1.csv", row.names=FALSE)

df_out = df %>% 
  gather(variable, value, -(month:student)) %>%
  unite(temp, student, variable) %>%
  spread(temp, value)

write.csv(df_out, "data-raw/r2_output1.csv", row.names=FALSE)

r2_output1 <- read.csv("data-raw/r2_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r2_output1, is.factor)
int.cols <- sapply(r2_output1, is.integer)

r2_output1[, fctr.cols] <- sapply(r2_output1[, fctr.cols], as.character)
r2_output1[, int.cols] <- sapply(r2_output1[, int.cols], as.numeric)
save(r2_output1, file = "data/r2_output1.rdata")

r2_input1 <- read.csv("data-raw/r2_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r2_input1, is.factor)
int.cols <- sapply(r2_input1, is.integer)

r2_input1[, fctr.cols] <- sapply(r2_input1[, fctr.cols], as.character)
r2_input1[, int.cols] <- sapply(r2_input1[, int.cols], as.numeric)
save(r2_input1, file = "data/r2_input1.rdata")


