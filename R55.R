# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 58
dat <- read.table(text=
"
ID  c_Al   c_D    c_Hy      occ
C     0     0      1        2581
D     1     0      1        1917
E     0     0      1        2708
F     0     1      0        2751
G     1     1      0        1522
", header=T)



write.csv(dat, "data-raw/r55_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(Var,Value, c_Al:c_Hy)%>%
  group_by(Value,Var)%>% 
  summarize(occNew=mean(occ))%>% 
  spread(Value, occNew)

write.csv(df_out, "data-raw/r55_output1.csv", row.names=FALSE)

r55_output1 <- read.csv("data-raw/r55_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r55_output1, is.factor)
int.cols <- sapply(r55_output1, is.integer)

r55_output1[, fctr.cols] <- sapply(r55_output1[, fctr.cols], as.character)
r55_output1[, int.cols] <- sapply(r55_output1[, int.cols], as.numeric)
save(r55_output1, file = "data/r55_output1.rdata")

r55_input1 <- read.csv("data-raw/r55_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r55_input1, is.factor)
int.cols <- sapply(r55_input1, is.integer)

r55_input1[, fctr.cols] <- sapply(r55_input1[, fctr.cols], as.character)
r55_input1[, int.cols] <- sapply(r55_input1[, int.cols], as.numeric)
save(r55_input1, file = "data/r55_input1.rdata")
