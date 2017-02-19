# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
#dat <- data.frame(Timepoint=c(0L, 7L, 14L), Group1=c(50L, 60L, 66L),
#                  Error1_Group1=c(3, 4, 6), Group2=c(30L, 60L, 90L),
#                  Error2_Group1=c(10L, 14L, 16L))


dat <- data.frame(Timepoint=c(7L, 14L), Group1=c(60L, 66L),
                  Error1_Group1=c(4, 6), Group2=c(60L, 90L),
                  Error2_Group1=c(14L, 16L))


write.csv(dat, "data-raw/r15_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather (g, m, Error1_Group1,Error2_Group1) %>%
  separate (g, c("Measure", "mGroup")) %>% 
  spread (Measure, m) %>% 
  select (1,2,3,5,4,6)
#  arrange (Timepoint) 

write.csv(df_out, "data-raw/r15_output1.csv", row.names=FALSE)

r15_output1 <- read.csv("data-raw/r15_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r15_output1, is.factor)
int.cols <- sapply(r15_output1, is.integer)

r15_output1[, fctr.cols] <- sapply(r15_output1[, fctr.cols], as.character)
r15_output1[, int.cols] <- sapply(r15_output1[, int.cols], as.numeric)
save(r15_output1, file = "data/r15_output1.rdata")

r15_input1 <- read.csv("data-raw/r15_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r15_input1, is.factor)
int.cols <- sapply(r15_input1, is.integer)

r15_input1[, fctr.cols] <- sapply(r15_input1[, fctr.cols], as.character)
r15_input1[, int.cols] <- sapply(r15_input1[, int.cols], as.numeric)
save(r15_input1, file = "data/r15_input1.rdata")
