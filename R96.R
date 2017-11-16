# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Subject    Var1    Var2    Var3
      A-pre    1    8    20
      A-post    2    9    21
      B-pre    3    10    27
      B-post    4    11    26
", header=T)

write.csv(dat, "data-raw/r96_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      Col1    Var1_pre    Var2_post    Var2_pre    Var3_post    Var3_pre
      A    1    9    8    21    20
      B    3    11    10    26    27
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r96_output1.csv", row.names=FALSE)

r96_output1 <- read.csv("data-raw/r96_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r96_output1, is.factor)
int.cols <- sapply(r96_output1, is.integer)

r96_output1[, fctr.cols] <- sapply(r96_output1[, fctr.cols], as.character)
r96_output1[, int.cols] <- sapply(r96_output1[, int.cols], as.numeric)
save(r96_output1, file = "data/r96_output1.rdata")

r96_input1 <- read.csv("data-raw/r96_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r96_input1, is.factor)
int.cols <- sapply(r96_input1, is.integer)

r96_input1[, fctr.cols] <- sapply(r96_input1[, fctr.cols], as.character)
r96_input1[, int.cols] <- sapply(r96_input1[, int.cols], as.numeric)
save(r96_input1, file = "data/r96_input1.rdata")
