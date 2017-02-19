# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <-data.frame(
   expr=c("base__1d4","base__1d4","base__1d5","base__1d5","dplyr_1d4","dplyr_1d4","dplyr_1d5","dplyr_1d5"),
   time=c(4203379,4219165,59249811,59249833,4911550,4911533,72271322,63373463)
)

write.csv(dat, "data-raw/r11_input1.csv", row.names=FALSE)

dat %>% group_by(expr) %>% summarise(mean = mean(time)) %>%
   separate(expr, c("system", "size")) %>%
   spread(system, mean) %>% mutate(ratio = base / dplyr) -> df_out


write.csv(df_out, "data-raw/r11_output1.csv", row.names=FALSE)

r11_output1 <- read.csv("data-raw/r11_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r11_output1, is.factor)
int.cols <- sapply(r11_output1, is.integer)

r11_output1[, fctr.cols] <- sapply(r11_output1[, fctr.cols], as.character)
r11_output1[, int.cols] <- sapply(r11_output1[, int.cols], as.numeric)
save(r11_output1, file = "data/r11_output1.rdata")

r11_input1 <- read.csv("data-raw/r11_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r11_input1, is.factor)
int.cols <- sapply(r11_input1, is.integer)

r11_input1[, fctr.cols] <- sapply(r11_input1[, fctr.cols], as.character)
r11_input1[, int.cols] <- sapply(r11_input1[, int.cols], as.numeric)
save(r11_input1, file = "data/r11_input1.rdata")
