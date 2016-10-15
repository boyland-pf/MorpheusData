# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat = data.frame(
  sequence = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2),
  foo = c(3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
  model = c("a", "b", "c", "d", "e", "a", "b", "c", "d", "e"),
  output = c(12, 29, 10, 38, 10, 38, 10, 29, 56, 10),
  real = c(12, 12, 12, 12, 12, 15, 15, 15, 15, 15)
)

write.csv(dat, "data-raw/p19_input1.csv", row.names=FALSE)

df_out = dat %>% spread(model, output) %>%
gather(model, output, -sequence, -foo) %>%
arrange(sequence, model)

write.csv(df_out, "data-raw/p19_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p19_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p19_output1.rdata")

input1 <- read.csv("data-raw/p19_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p19_input1.rdata")
