# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- data.frame(Timepoint=c(0L, 7L, 14L, 21L, 28L), Group1=c(50L, 60L, 66L, 88L, 90L),
             Error_Group1=c(3, 4, 6, 8, 2), Group2=c(30L, 60L, 90L, 120L, 150L),
             Error_Group2=c(10L, 14L, 16L, 13L, 25L))

write.csv(dat, "data-raw/p15_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather (g, m, -Timepoint) %>%
  separate (g, c("Measure", "mGroup"), -2) %>% 
  spread (Measure, m) %>% 
  select (Timepoint, mGroup, Group, Error_Group) %>%
  arrange (Group) 

write.csv(df_out, "data-raw/p15_output1.csv", row.names=FALSE)

p15_output1 <- read.csv("data-raw/p15_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p15_output1, is.factor)
int.cols <- sapply(p15_output1, is.integer)

p15_output1[, fctr.cols] <- sapply(p15_output1[, fctr.cols], as.character)
p15_output1[, int.cols] <- sapply(p15_output1[, int.cols], as.numeric)
save(p15_output1, file = "data/p15_output1.rdata")

p15_input1 <- read.csv("data-raw/p15_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p15_input1, is.factor)
int.cols <- sapply(p15_input1, is.integer)

p15_input1[, fctr.cols] <- sapply(p15_input1[, fctr.cols], as.character)
p15_input1[, int.cols] <- sapply(p15_input1[, int.cols], as.numeric)
save(p15_input1, file = "data/p15_input1.rdata")
