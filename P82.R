# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 82
dat <- read.table(text=
                       "Title Rating Action Sci.Fi
                       Carrie      4      0      1
         Fried-Green-Tomatoes      2      0      0
                      Amadeus      5      1      0
       Amityville-Horror      1      0      0
  Dracula      2      0      1
                        Speed      4      1      0
 ", header=T)

write.csv(dat, "data-raw/p82_input1.csv", row.names=FALSE)

df_out = dat %>% gather(genre, value, Action, Sci.Fi) %>% filter(value == 1) %>%
    group_by(genre) %>% summarize(average = mean(Rating))

write.csv(df_out, "data-raw/p82_output1.csv", row.names=FALSE)

p82_output1 <- read.csv("data-raw/p82_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p82_output1, is.factor)
int.cols <- sapply(p82_output1, is.integer)

p82_output1[, fctr.cols] <- sapply(p82_output1[, fctr.cols], as.character)
p82_output1[, int.cols] <- sapply(p82_output1[, int.cols], as.numeric)
save(p82_output1, file = "data/p82_output1.rdata")

p82_input1 <- read.csv("data-raw/p82_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p82_input1, is.factor)
int.cols <- sapply(p82_input1, is.integer)

p82_input1[, fctr.cols] <- sapply(p82_input1[, fctr.cols], as.character)
p82_input1[, int.cols] <- sapply(p82_input1[, int.cols], as.numeric)
save(p82_input1, file = "data/p82_input1.rdata")
