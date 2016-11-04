# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 36
dat <- read.table(text=
"
name1 con1_1 con1_2 con2_1 
a     23     33     23    
b     25     34     22   
c     28     29     30  
", header=T)



write.csv(dat, "data-raw/p36_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, val, -name1) %>%
  separate(var, c("var", "time")) %>%
  group_by(name1, var) %>%
  summarise(mVal = mean(val)) %>%
  spread(var, mVal)

write.csv(df_out, "data-raw/p36_output1.csv", row.names=FALSE)

p36_output1 <- read.csv("data-raw/p36_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p36_output1, is.factor)
int.cols <- sapply(p36_output1, is.integer)

p36_output1[, fctr.cols] <- sapply(p36_output1[, fctr.cols], as.character)
p36_output1[, int.cols] <- sapply(p36_output1[, int.cols], as.numeric)
save(p36_output1, file = "data/p36_output1.rdata")

p36_input1 <- read.csv("data-raw/p36_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p36_input1, is.factor)
int.cols <- sapply(p36_input1, is.integer)

p36_input1[, fctr.cols] <- sapply(p36_input1[, fctr.cols], as.character)
p36_input1[, int.cols] <- sapply(p36_input1[, int.cols], as.numeric)
save(p36_input1, file = "data/p36_input1.rdata")
