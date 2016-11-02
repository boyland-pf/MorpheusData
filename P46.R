# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 46
dat <- read.table(text=
"
V1 V2 V3 V4 V5
a  b  a  EMP EMP   
a  b  EMP   c   EMP
a  b  EMP   EMP   d
x  y  h  EMP EMP    
x  y EMP    k  e
", header=T)



write.csv(dat, "data-raw/p46_input1.csv", row.names=FALSE)

df_out = dat %>%
        gather(Var, Val, V3:V5) %>% 
              filter(Val!='EMP') %>% 
              spread(Var, Val)

write.csv(df_out, "data-raw/p46_output1.csv", row.names=FALSE)

p46_output1 <- read.csv("data-raw/p46_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p46_output1, is.factor)
int.cols <- sapply(p46_output1, is.integer)

p46_output1[, fctr.cols] <- sapply(p46_output1[, fctr.cols], as.character)
p46_output1[, int.cols] <- sapply(p46_output1[, int.cols], as.numeric)
save(p46_output1, file = "data/p46_output1.rdata")

p46_input1 <- read.csv("data-raw/p46_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p46_input1, is.factor)
int.cols <- sapply(p46_input1, is.integer)

p46_input1[, fctr.cols] <- sapply(p46_input1[, fctr.cols], as.character)
p46_input1[, int.cols] <- sapply(p46_input1[, int.cols], as.numeric)
save(p46_input1, file = "data/p46_input1.rdata")
