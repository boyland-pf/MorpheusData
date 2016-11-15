# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)

#############benchmark 26
t1  <- read.table(text=
"
 source    tone value
Politician     For     3
Politician     For     4
Politician     For     1
Politician Against     4
Politician Against     2
Politician Against     10
Activist     For     2
Activist     For     1
Activist     For     2
Activist Against     3
Activist Against     5
Activist Against     11
",header=T)

df_out =   t1 %>% group_by(source, tone) %>%
    summarise(avg=mean(value)) %>%
    gather(type, val, -source, -tone) %>%
    unite(stat, c(tone, type)) %>%
    spread(stat, val)

#df_out

write.csv(df_out, "data-raw/p26_output1.csv", row.names=FALSE)
write.csv(t1, "data-raw/p26_input1.csv", row.names=FALSE)

p26_output1 <- read.csv("data-raw/p26_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p26_output1, is.factor)
int.cols <- sapply(p26_output1, is.integer)

p26_output1[, fctr.cols] <- sapply(p26_output1[, fctr.cols], as.character)
p26_output1[, int.cols] <- sapply(p26_output1[, int.cols], as.numeric)
save(p26_output1, file = "data/p26_output1.rdata")

p26_input1 <- read.csv("data-raw/p26_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p26_input1, is.factor)
int.cols <- sapply(p26_input1, is.integer)

p26_input1[, fctr.cols] <- sapply(p26_input1[, fctr.cols], as.character)
p26_input1[, int.cols] <- sapply(p26_input1[, int.cols], as.numeric)
save(p26_input1, file = "data/p26_input1.rdata")
