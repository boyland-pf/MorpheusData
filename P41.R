# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 41
File1 = read.table(text="ID  miRNA
ID1 hsa-miR-512-1
ID1 hsa-miR-512-2
ID1 hsa-miR-1323
ID1 hsa-miR-498
ID1 hsa-miR-520e
ID1 hsa-miR-515-1
ID1 hsa-miR-519e
ID1 hsa-miR-520f
ID2 hsa-miR-495
ID2 hsa-miR-376c
ID2 hsa-miR-376a-2
ID2 hsa-miR-654
ID2 hsa-miR-376b
ID2 hsa-miR-376a-1
ID2 hsa-miR-300
ID2 hsa-miR-1185-1
ID2 hsa-miR-1185-2
ID24    hsa-miR-1179
ID24    hsa-miR-7-2
ID24    hsa-miR-3677
ID25    hsa-miR-940
ID25    hsa-miR-4717", header=T)

File2 = read.table(text="miRNA           logFC
hsa-miR-512-1   13
hsa-miR-512-2   123 
hsa-miR-1323    53
hsa-miR-498     4.2
hsa-miR-520e    12
hsa-miR-515-1   1
hsa-miR-519e    56
hsa-miR-520f    113
hsa-miR-495     11
hsa-miR-376c    11
hsa-miR-376a-2  113 
hsa-miR-654     13
hsa-miR-376b    123
hsa-miR-376a-1  567
hsa-miR-300     757
hsa-miR-1185-1   6
hsa-miR-1185-2  35
hsa-miR-1179    2
hsa-miR-7-2     2
hsa-miR-3677    1
hsa-miR-940     134
hsa-miR-4717    566", header=T)



write.csv(File1, "data-raw/p41_input1.csv", row.names=FALSE)
write.csv(File2, "data-raw/p41_input2.csv", row.names=FALSE)

df_out = File1 %>% 
  inner_join(File2) %>%     # join your datasets based on miRNA column
  group_by(ID) %>%                      # group by ID
  summarise(AvgLogFC = mean(logFC))

write.csv(df_out, "data-raw/p41_output1.csv", row.names=FALSE)

p41_output1 <- read.csv("data-raw/p41_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p41_output1, is.factor)
int.cols <- sapply(p41_output1, is.integer)

p41_output1[, fctr.cols] <- sapply(p41_output1[, fctr.cols], as.character)
p41_output1[, int.cols] <- sapply(p41_output1[, int.cols], as.numeric)
save(p41_output1, file = "data/p41_output1.rdata")

p41_input1 <- read.csv("data-raw/p41_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p41_input1, is.factor)
int.cols <- sapply(p41_input1, is.integer)

p41_input1[, fctr.cols] <- sapply(p41_input1[, fctr.cols], as.character)
p41_input1[, int.cols] <- sapply(p41_input1[, int.cols], as.numeric)
save(p41_input1, file = "data/p41_input1.rdata")


p41_input2 <- read.csv("data-raw/p41_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p41_input2, is.factor)
int.cols <- sapply(p41_input2, is.integer)

p41_input2[, fctr.cols] <- sapply(p41_input2[, fctr.cols], as.character)
p41_input2[, int.cols] <- sapply(p41_input2[, int.cols], as.numeric)
save(p41_input2, file = "data/p41_input2.rdata")
