# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
#dat <- subset(mtcars, gear>3 & cyl >= 4 & hp > 100)
dat <- read.table(text=
"GeneID     D.1     T.1      D.8    
A2M  18 50 A1 
ABL1 20 48 C1
ACP1 16 8  E1
", header=T)

write.csv(dat, "data-raw/p7_input1.csv", row.names=FALSE)

df_out = dat %>% gather(pt.num.type, value, 2:3) %>%
     separate(pt.num.type, c("type", "pt.num")) %>%
     spread(type, value) %>%
     mutate(Ratio = D/T) %>% select(-`D.8`)

write.csv(df_out, "data-raw/p7_output1.csv", row.names=FALSE)

p7_output1 <- read.csv("data-raw/p7_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p7_output1, is.factor)
int.cols <- sapply(p7_output1, is.integer)

p7_output1[, fctr.cols] <- sapply(p7_output1[, fctr.cols], as.character)
p7_output1[, int.cols] <- sapply(p7_output1[, int.cols], as.numeric)
save(p7_output1, file = "data/p7_output1.rdata")

p7_input1 <- read.csv("data-raw/p7_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p7_input1, is.factor)
int.cols <- sapply(p7_input1, is.integer)

p7_input1[, fctr.cols] <- sapply(p7_input1[, fctr.cols], as.character)
p7_input1[, int.cols] <- sapply(p7_input1[, int.cols], as.numeric)
save(p7_input1, file = "data/p7_input1.rdata")
