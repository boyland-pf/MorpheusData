# making table data sets
library(dplyr)
library(tidyr)

who <- read.csv("data-raw/who.csv")
population <- read.csv("data-raw/population.csv")

table1 <- 
  who %>%
  filter(country %in% c("Afghanistan", "Brazil", "China"),
         year >= 1999, year <= 2000) %>% 
  gather("code", "value", 5:60) %>% 
  group_by(country, year) %>% 
  summarise(cases = sum(value, na.rm = TRUE)) %>%
  ungroup() %>%
  left_join(population, by = c("country", "year"))

b1_input1 <- 
  table1 %>% 
  gather("key", "value", 3:4) %>% 
  arrange(country, year)

b2_input1 <-
  table1 %>% 
  unite("rate", cases, population, sep = "/")

write.csv(table1, file = "data-raw/b1_input1.csv", row.names = FALSE)
write.csv(table2, file = "data-raw/b2_input1.csv", row.names = FALSE)

save(b1_input1, file = "data/b1_input1.rdata")
save(b2_input1, file = "data/b2_input1.rdata")
