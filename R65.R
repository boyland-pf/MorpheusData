# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
#How to solve this could be our future work.
dat <- read.table(text=
"ID  MGW.one MGW.two  HEL.one HEL.two
A  10.00    19      12 13.00  
B -13.29    13      12 -0.12  
C  -6.95    10     15  4.00   
", header=T)

#dat <- read.table(text=
#"ID  MGW.one MGW.two  HEL.mean
#A  10.00    19.00     19
#B -13.29    13.00  	  13
#C  -6.95    10.00     10
#", header=T)


write.csv(dat, "data-raw/r65_input1.csv", row.names=FALSE)

df_out = dat %>% gather(key, value, -`ID`) %>%
  separate(key, into = c("label", "num")) %>%
  group_by(ID, label) %>%
  summarise(mean = mean(value)) %>%
  spread(label, mean)

# df_out = dat %>% select(-`HEL.mean`) %>% gather(key, value, -`ID`) %>%
#   group_by(ID) %>%
#   summarise(mean = mean(value))

write.csv(df_out, "data-raw/r65_output1.csv", row.names=FALSE)

r65_output1 <- read.csv("data-raw/r65_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r65_output1, is.factor)
int.cols <- sapply(r65_output1, is.integer)

r65_output1[, fctr.cols] <- sapply(r65_output1[, fctr.cols], as.character)
r65_output1[, int.cols] <- sapply(r65_output1[, int.cols], as.numeric)
save(r65_output1, file = "data/r65_output1.rdata")

r65_input1 <- read.csv("data-raw/r65_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r65_input1, is.factor)
int.cols <- sapply(r65_input1, is.integer)

r65_input1[, fctr.cols] <- sapply(r65_input1[, fctr.cols], as.character)
r65_input1[, int.cols] <- sapply(r65_input1[, int.cols], as.numeric)
save(r65_input1, file = "data/r65_input1.rdata")
