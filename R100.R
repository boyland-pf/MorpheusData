# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      id    time    Q1.1    Q1.2    Q2.1    Q2.2    Q3.1    Q3.2
      1    2009-01-01    0.48742885    -0.01618826    1.52718069    -0.29177677    0.48742885    -0.01618826
      2    2009-01-02    0.73832471    0.94383621    -0.40380049    -1.19813815    0.73832471    0.94383621
", header=T)

write.csv(dat, "data-raw/r100_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      id    time    Q1    Q2    Q3
      1    2009-01-01    0.48742885    1.52718069    0.48742885
      1    2009-01-01    -0.01618826    -0.29177677    -0.01618826
      2    2009-01-02    0.73832471    -0.40380049    0.73832471
      2    2009-01-02    0.94383621    -1.19813815    0.94383621
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r100_output1.csv", row.names=FALSE)

r100_output1 <- read.csv("data-raw/r100_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r100_output1, is.factor)
int.cols <- sapply(r100_output1, is.integer)

r100_output1[, fctr.cols] <- sapply(r100_output1[, fctr.cols], as.character)
r100_output1[, int.cols] <- sapply(r100_output1[, int.cols], as.numeric)
save(r100_output1, file = "data/r100_output1.rdata")

r100_input1 <- read.csv("data-raw/r100_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r100_input1, is.factor)
int.cols <- sapply(r100_input1, is.integer)

r100_input1[, fctr.cols] <- sapply(r100_input1[, fctr.cols], as.character)
r100_input1[, int.cols] <- sapply(r100_input1[, int.cols], as.numeric)
save(r100_input1, file = "data/r100_input1.rdata")
