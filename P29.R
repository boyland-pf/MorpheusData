# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 29
attributes <- read.table(text=
"Species	Attribute
Callvulg        MI
Empenigr        MI
Vaccmyrt        MI
Cladfimb        PI
Cladcris        PI
Cladchlo        PI
", header=T)

dat <- read.table(text=
"ID Callvulg Empenigr Rhodtome 
1     0.55    11.13     0.00    
2     0.67     0.17     0.00     
3     0.10     1.55     0.00    
4     4.73     5.12     1.55  
5     4.47     7.33     0.00",
header=T)

dat = gather(dat, Species, Value, -ID)

write.csv(dat, "data-raw/p29_input1.csv", row.names=FALSE)
write.csv(attributes, "data-raw/p29_input2.csv", row.names=FALSE)

df_out = dat %>% 
  inner_join(attributes) %>% 
  filter(Attribute == "MI") %>% 
  group_by(ID) %>% 
  summarise(Total = sum(Value))

write.csv(df_out, "data-raw/p29_output1.csv", row.names=FALSE)

p29_output1 <- read.csv("data-raw/p29_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p29_output1, is.factor)
int.cols <- sapply(p29_output1, is.integer)

p29_output1[, fctr.cols] <- sapply(p29_output1[, fctr.cols], as.character)
p29_output1[, int.cols] <- sapply(p29_output1[, int.cols], as.numeric)
save(p29_output1, file = "data/p29_output1.rdata")

p29_input1 <- read.csv("data-raw/p29_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p29_input1, is.factor)
int.cols <- sapply(p29_input1, is.integer)

p29_input1[, fctr.cols] <- sapply(p29_input1[, fctr.cols], as.character)
p29_input1[, int.cols] <- sapply(p29_input1[, int.cols], as.numeric)
save(p29_input1, file = "data/p29_input1.rdata")

p29_input2 <- read.csv("data-raw/p29_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p29_input2, is.factor)
int.cols <- sapply(p29_input2, is.integer)

p29_input2[, fctr.cols] <- sapply(p29_input2[, fctr.cols], as.character)
p29_input2[, int.cols] <- sapply(p29_input2[, int.cols], as.numeric)
save(p29_input2, file = "data/p29_input2.rdata")
