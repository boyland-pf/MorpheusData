# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 12
dat <- read.table(text=
"flight origin dest
1141    JFK   MIA
725    JFK   BQN
461    LGA   ATL
1696    EWR   ORD
507    EWR   FLL
5708    LGA   IAD
79    JFK   MCO
301    LGA   ORD
11    EWR   SEA
495    JFK   SEA
1670    EWR   SEA
", header=T)

write.csv(dat, "data-raw/p12_input1.csv", row.names=FALSE)

df_out = dat %>% 
    filter(dest=="SEA") %>%
    group_by(origin) %>% 
    dplyr::summarise (n = n()) %>%
    dplyr::mutate(freq = n / sum(n))

write.csv(df_out, "data-raw/p12_output1.csv", row.names=FALSE)

p12_output1 <- read.csv("data-raw/p12_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p12_output1, is.factor)
int.cols <- sapply(p12_output1, is.integer)

p12_output1[, fctr.cols] <- sapply(p12_output1[, fctr.cols], as.character)
p12_output1[, int.cols] <- sapply(p12_output1[, int.cols], as.numeric)
save(p12_output1, file = "data/p12_output1.rdata")

p12_input1 <- read.csv("data-raw/p12_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p12_input1, is.factor)
int.cols <- sapply(p12_input1, is.integer)

p12_input1[, fctr.cols] <- sapply(p12_input1[, fctr.cols], as.character)
p12_input1[, int.cols] <- sapply(p12_input1[, int.cols], as.numeric)
save(p12_input1, file = "data/p12_input1.rdata")
