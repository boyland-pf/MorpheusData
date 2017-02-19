# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 47
dat = data.frame(name=c("A","A","B","B"),
                group=c("g1","g2","g1","g2"),
                V1=c(10,40,20,30),
                V2=c(6,3,1,7))

write.csv(dat, "data-raw/r46_input1.csv", row.names=FALSE)

df_out = dat %>% gather(Var, Val, V1:V2) %>% 
                    unite(VarG, Var, group) %>% 
                    spread(VarG, Val)

write.csv(df_out, "data-raw/r46_output1.csv", row.names=FALSE)

r46_output1 <- read.csv("data-raw/r46_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r46_output1, is.factor)
int.cols <- sapply(r46_output1, is.integer)

r46_output1[, fctr.cols] <- sapply(r46_output1[, fctr.cols], as.character)
r46_output1[, int.cols] <- sapply(r46_output1[, int.cols], as.numeric)
save(r46_output1, file = "data/r46_output1.rdata")

r46_input1 <- read.csv("data-raw/r46_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r46_input1, is.factor)
int.cols <- sapply(r46_input1, is.integer)

r46_input1[, fctr.cols] <- sapply(r46_input1[, fctr.cols], as.character)
r46_input1[, int.cols] <- sapply(r46_input1[, int.cols], as.numeric)
save(r46_input1, file = "data/r46_input1.rdata")
