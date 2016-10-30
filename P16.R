# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"ID  Color    Type     W1     W2     
1    red Outdoor  74.22  26.86  
2    red  Indoor  78.59 138.80  
7    red  Indoor  38.41  84.81
8    red Outdoor 140.68  93.33
9 yellow Outdoor  65.95 104.31
", header=T)

write.csv(dat, "data-raw/p16_input1.csv", row.names=FALSE)

# Original solution from stackoverflow.
#df_out = dat %>%  gather(Week, Value, 4:5) %>%
#        filter(Value > 38.41) %>%
#        group_by(Color,Week) %>%
#        summarise(Count = n()) %>%
#        spread(Week, Count)

df_out = dat %>% filter(`W2` > 26.860000) %>% 
         group_by(`Color`) %>% summarise(sumCount=n()) %>% 
         group_by(`Color`,`sumCount`) %>% summarise(sumMean=mean(`sumCount`)) 

write.csv(df_out, "data-raw/p16_output1.csv", row.names=FALSE)

p16_output1 <- read.csv("data-raw/p16_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p16_output1, is.factor)
int.cols <- sapply(p16_output1, is.integer)

p16_output1[, fctr.cols] <- sapply(p16_output1[, fctr.cols], as.character)
p16_output1[, int.cols] <- sapply(p16_output1[, int.cols], as.numeric)
save(p16_output1, file = "data/p16_output1.rdata")

p16_input1 <- read.csv("data-raw/p16_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p16_input1, is.factor)
int.cols <- sapply(p16_input1, is.integer)

p16_input1[, fctr.cols] <- sapply(p16_input1[, fctr.cols], as.character)
p16_input1[, int.cols] <- sapply(p16_input1[, int.cols], as.numeric)
save(p16_input1, file = "data/p16_input1.rdata")
