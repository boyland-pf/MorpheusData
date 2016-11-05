# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 58
dat <- read.table(text=
"
ID  c_Al   c_D    c_Hy      occ
A     0     0      0        2306
B     0     0      0        3031
C     0     0      1        2581
D     1     0      1        1917
E     0     0      1        2708
F     0     1      0        2751
G     1     1      0        1522
H     0     1      0        657
I     0     1      1        469
J     0     1      1        2629
", header=T)



write.csv(dat, "data-raw/p58_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(Var,Value, c_Al:c_Hy)%>%
  group_by(Value,Var)%>% 
  summarize(occNew=mean(occ))%>% 
  spread(Value, occNew)

write.csv(df_out, "data-raw/p58_output1.csv", row.names=FALSE)

p58_output1 <- read.csv("data-raw/p58_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p58_output1, is.factor)
int.cols <- sapply(p58_output1, is.integer)

p58_output1[, fctr.cols] <- sapply(p58_output1[, fctr.cols], as.character)
p58_output1[, int.cols] <- sapply(p58_output1[, int.cols], as.numeric)
save(p58_output1, file = "data/p58_output1.rdata")

p58_input1 <- read.csv("data-raw/p58_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p58_input1, is.factor)
int.cols <- sapply(p58_input1, is.integer)

p58_input1[, fctr.cols] <- sapply(p58_input1[, fctr.cols], as.character)
p58_input1[, int.cols] <- sapply(p58_input1[, int.cols], as.numeric)
save(p58_input1, file = "data/p58_input1.rdata")
