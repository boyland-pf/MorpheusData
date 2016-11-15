# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
sample_ID   site      species TOT inf_status
382870  site_1  Species_B   1   positive
487405  site_2  Species_A   1   positive
487405  site_2  Species_B   1   positive
487405  site_2  Species_A   1   positive
382899  site_1  Species_A   1   positive
", header=T)

write.csv(dat, "data-raw/p86_input1.csv", row.names=FALSE)

df_out = dat %>% 
    unite(sp_status, species, inf_status) %>%
    group_by(site, sp_status) %>%
    summarise(TOTSum = sum(TOT)) %>%
    spread(sp_status,  TOTSum)

write.csv(df_out, "data-raw/p86_output1.csv", row.names=FALSE)

p86_output1 <- read.csv("data-raw/p86_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p86_output1, is.factor)
int.cols <- sapply(p86_output1, is.integer)

p86_output1[, fctr.cols] <- sapply(p86_output1[, fctr.cols], as.character)
p86_output1[, int.cols] <- sapply(p86_output1[, int.cols], as.numeric)
save(p86_output1, file = "data/p86_output1.rdata")

p86_input1 <- read.csv("data-raw/p86_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p86_input1, is.factor)
int.cols <- sapply(p86_input1, is.integer)

p86_input1[, fctr.cols] <- sapply(p86_input1[, fctr.cols], as.character)
p86_input1[, int.cols] <- sapply(p86_input1[, int.cols], as.numeric)
save(p86_input1, file = "data/p86_input1.rdata")
