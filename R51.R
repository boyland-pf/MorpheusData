# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 54
dat <- read.table(text=
"
   Geotype   Strategy Year.1 Year.2 
A     Demand      1      5     
A Strategy_1      2      6    
A Strategy_2      3      7   
B     Demand      8      8  
B Strategy_1      9      9 
B Strategy_2     10     10
", header=T)


write.csv(dat, "data-raw/r51_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(key, value, - Geotype, - Strategy) %>%
  filter(Strategy!="Demand") %>% group_by(Geotype, key) %>%
  summarize(sumVal = sum(value))

write.csv(df_out, "data-raw/r51_output1.csv", row.names=FALSE)

r51_output1 <- read.csv("data-raw/r51_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r51_output1, is.factor)
int.cols <- sapply(r51_output1, is.integer)

r51_output1[, fctr.cols] <- sapply(r51_output1[, fctr.cols], as.character)
r51_output1[, int.cols] <- sapply(r51_output1[, int.cols], as.numeric)
save(r51_output1, file = "data/r51_output1.rdata")

r51_input1 <- read.csv("data-raw/r51_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r51_input1, is.factor)
int.cols <- sapply(r51_input1, is.integer)

r51_input1[, fctr.cols] <- sapply(r51_input1[, fctr.cols], as.character)
r51_input1[, int.cols] <- sapply(r51_input1[, int.cols], as.numeric)
save(r51_input1, file = "data/r51_input1.rdata")
