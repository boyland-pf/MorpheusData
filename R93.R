# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      sample_ID    site    species    TOT    inf_status
      382870    site_3    Species_C    5    negative
      382872    site_2    Species_B    1    negative
      487405    site_3    Species_A    4    positive
      487405    site_3    Species_A    1    positive
      382899    site_1    Species_A    1    positive
      382900    site_2    Species_A    1    positive
      382901    site_3    Species_A    1    positive
      382902    site_2    Species_A    5    negative
      382903    site_1    Species_B    1    negative
      382904    site_2    Species_C    9    negative
      382905    site_3    Species_A    13    negative
      382906    site_3    Species_B    1    negative
      382907    site_1    Species_A    1    negative
      382908    site_1    Species_C    1    negative
", header=T)

write.csv(dat, "data-raw/r93_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      site    Species_A_negative    Species_A_positive    Species_B_negative    Species_C_negative
      site_1    1    1    1    1
      site_2    5    1    1    9
      site_3    13    6    1    5
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r93_output1.csv", row.names=FALSE)

r93_output1 <- read.csv("data-raw/r93_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r93_output1, is.factor)
int.cols <- sapply(r93_output1, is.integer)

r93_output1[, fctr.cols] <- sapply(r93_output1[, fctr.cols], as.character)
r93_output1[, int.cols] <- sapply(r93_output1[, int.cols], as.numeric)
save(r93_output1, file = "data/r93_output1.rdata")

r93_input1 <- read.csv("data-raw/r93_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r93_input1, is.factor)
int.cols <- sapply(r93_input1, is.integer)

r93_input1[, fctr.cols] <- sapply(r93_input1[, fctr.cols], as.character)
r93_input1[, int.cols] <- sapply(r93_input1[, int.cols], as.numeric)
save(r93_input1, file = "data/r93_input1.rdata")
