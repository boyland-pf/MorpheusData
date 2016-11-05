# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
#How to solve this could be our future work.
#dat <- read.table(text=
#"ID  MGW.one MGW.two  HEL.one HEL.two
#A  10.00    19      12 13.00  
#B -13.29    13      12 -0.12  
#C  -6.95    10     15  4.00   
#", header=T)

dat <- read.table(text=
"ID  MGW.one MGW.two  
A  10.00    19      
B -13.29    13     
C  -6.95    10    
", header=T)


write.csv(dat, "data-raw/p74_input1.csv", row.names=FALSE)

df_out = dat %>% gather(key, value, -`ID`) %>%
  separate(key, into = c("label", "num")) %>%
  group_by(ID, label) %>%
  summarise(mean = mean(value)) %>%
  spread(label, mean)

write.csv(df_out, "data-raw/p74_output1.csv", row.names=FALSE)

p74_output1 <- read.csv("data-raw/p74_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p74_output1, is.factor)
int.cols <- sapply(p74_output1, is.integer)

p74_output1[, fctr.cols] <- sapply(p74_output1[, fctr.cols], as.character)
p74_output1[, int.cols] <- sapply(p74_output1[, int.cols], as.numeric)
save(p74_output1, file = "data/p74_output1.rdata")

p74_input1 <- read.csv("data-raw/p74_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p74_input1, is.factor)
int.cols <- sapply(p74_input1, is.integer)

p74_input1[, fctr.cols] <- sapply(p74_input1[, fctr.cols], as.character)
p74_input1[, int.cols] <- sapply(p74_input1[, int.cols], as.numeric)
save(p74_input1, file = "data/p74_input1.rdata")
