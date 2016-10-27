# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 29
data(varespec, package = "vegan")
attributes <- data.frame(
  Species = c(colnames(varespec), "spec1", "spec2"),
  Attribute = c(rep(c("MI", "PI"), c(14, 30)), "MI", "PI")
)
tmp1 = select(varespec,1:4)
tmp2 = slice(tmp1,1:8)
dat = add_rownames(tmp2,"ID")

write.csv(dat, "data-raw/p29_input1.csv", row.names=FALSE)

df_out = dat %>% 
  gather(Species, Value, -ID) %>%
  inner_join(attributes) %>% 
  filter(Attribute == "MI") %>% 
  group_by(ID) %>% 
  summarise(Total = sum(Value))

write.csv(df_out, "data-raw/p29_output1.csv", row.names=FALSE)

p29_output1 <- read.csv("data-raw/p29_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p29_output1, is.factor)
int.cols <- sapply(p29_output1, is.integer)

p29_output1[, fctr.cols] <- sapply(p29_output1[, fctr.cols], as.character)
p29_output1[, int.cols] <- sapply(p29_output1[, int.cols], as.numeric)
save(p29_output1, file = "data/p29_output1.rdata")

p29_input1 <- read.csv("data-raw/p29_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p29_input1, is.factor)
int.cols <- sapply(p29_input1, is.integer)

p29_input1[, fctr.cols] <- sapply(p29_input1[, fctr.cols], as.character)
p29_input1[, int.cols] <- sapply(p29_input1[, int.cols], as.numeric)
save(p29_input1, file = "data/p29_input1.rdata")
