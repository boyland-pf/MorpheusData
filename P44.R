# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 44
dat <- read.table(text=
"
      Day HL.Average D.Average LL.Average noHKB.Average    HL.SD      D.SD    LL.SD noHKB.SD
1 0.00000       8760      8900      10000          8030 2337.844  924.2742 1120.785 1592.646
2 1.90625      13300     11900      12100          3860 1016.291 2308.2661 3581.763 1031.057
3 3.00000      14500      7320      12300          1750 2945.098 1308.0389 4338.897 1793.583
4 4.00000      16200      9160      15100          2710 1006.893  514.2177 4362.261 2691.648
", header=T)



write.csv(dat, "data-raw/p44_input1.csv", row.names=FALSE)

df_out = dat %>%
   gather(key, value, -Day) %>%          # gather all columns except "Day" into "key" and "value" columns
   separate(key, c("Group", "tmp")) %>%  # separate the "key" column using "." into "Group", "tmp"
   spread(tmp, value)       

write.csv(df_out, "data-raw/p44_output1.csv", row.names=FALSE)

p44_output1 <- read.csv("data-raw/p44_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p44_output1, is.factor)
int.cols <- sapply(p44_output1, is.integer)

p44_output1[, fctr.cols] <- sapply(p44_output1[, fctr.cols], as.character)
p44_output1[, int.cols] <- sapply(p44_output1[, int.cols], as.numeric)
save(p44_output1, file = "data/p44_output1.rdata")

p44_input1 <- read.csv("data-raw/p44_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p44_input1, is.factor)
int.cols <- sapply(p44_input1, is.integer)

p44_input1[, fctr.cols] <- sapply(p44_input1[, fctr.cols], as.character)
p44_input1[, int.cols] <- sapply(p44_input1[, int.cols], as.numeric)
save(p44_input1, file = "data/p44_input1.rdata")
