# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1

dat <- read.table(text=
"GeneID     D.1     T.1  D.2 T.2   D.8    
A2M  18 50 2  6 A1 
ABL1 20 48 4  8 C1
", header=T)

#dat <- read.table(text=
#"GeneID     D.1     T.1      D.8    
#A2M  18 50 A1 
#ABL1 20 48 C1
#ACP1 16 8  E1
#", header=T)

write.csv(dat, "data-raw/r7_input1.csv", row.names=FALSE)

df_out = dat %>% gather(pt.num.type, value, 2:5) %>%
     separate(pt.num.type, c("type", "pt.num")) %>%
     spread(type, value) %>%
     mutate(Ratio = D/T) %>% select(-`D.8`)

write.csv(df_out, "data-raw/r7_output1.csv", row.names=FALSE)

r7_output1 <- read.csv("data-raw/r7_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r7_output1, is.factor)
int.cols <- sapply(r7_output1, is.integer)

r7_output1[, fctr.cols] <- sapply(r7_output1[, fctr.cols], as.character)
r7_output1[, int.cols] <- sapply(r7_output1[, int.cols], as.numeric)
save(r7_output1, file = "data/r7_output1.rdata")

r7_input1 <- read.csv("data-raw/r7_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r7_input1, is.factor)
int.cols <- sapply(r7_input1, is.integer)

r7_input1[, fctr.cols] <- sapply(r7_input1[, fctr.cols], as.character)
r7_input1[, int.cols] <- sapply(r7_input1[, int.cols], as.numeric)
save(r7_input1, file = "data/r7_input1.rdata")
