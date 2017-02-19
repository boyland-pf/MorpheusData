# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"Player Team	Shots	Passes	Tackles
Abdoun	Algeria       0      6       0
Abe 	Japan       3    101      14     
Abidal  France         0     91       6     
Abreu       Uruguay     5     15       0     
", header=T)

write.csv(dat, "data-raw/r22_input1.csv", row.names=FALSE)

df_out =  dat %>% gather(Var, Val, -`Player`, -`Team`) %>% 
       filter(Var!= "Shots") %>%
       group_by(Var) %>% 
       summarise(Mean = mean(Val))

write.csv(df_out, "data-raw/r22_output1.csv", row.names=FALSE)

r22_output1 <- read.csv("data-raw/r22_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r22_output1, is.factor)
int.cols <- sapply(r22_output1, is.integer)

r22_output1[, fctr.cols] <- sapply(r22_output1[, fctr.cols], as.character)
r22_output1[, int.cols] <- sapply(r22_output1[, int.cols], as.numeric)
save(r22_output1, file = "data/r22_output1.rdata")

r22_input1 <- read.csv("data-raw/r22_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r22_input1, is.factor)
int.cols <- sapply(r22_input1, is.integer)

r22_input1[, fctr.cols] <- sapply(r22_input1[, fctr.cols], as.character)
r22_input1[, int.cols] <- sapply(r22_input1[, int.cols], as.numeric)
save(r22_input1, file = "data/r22_input1.rdata")
