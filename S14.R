# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
catalog <- read.table(text=
"supplier_key part_id
S1 P1
S1 P2
S2 P1
S2 P2
S2 P3
S3 P3
S4 P2
S5 P1
S5 P2
S5 P3", header=T)

parts <- read.table(text=
"part_id color
P1 red
P2 green
P3 yellow", header=T)

suppliers <- read.table(text=
"supplier_key sname
S1 SN1
S2 SN2
S3 SN3
S4 SN4
S5 SN5", header=T)

# write.csv(catalog, "sql/catalog.csv", row.names=FALSE)

# catalog <- read.csv("sql/catalog.csv", check.names = FALSE)
# fctr.cols <- sapply(catalog, is.factor)
# int.cols <- sapply(catalog, is.integer)
# catalog[, fctr.cols] <- sapply(catalog[, fctr.cols], as.character)
# catalog[, int.cols] <- sapply(catalog[, int.cols], as.numeric)
# save(catalog, file = "sql/catalog.rdata")


# write.csv(suppliers, "sql/suppliers.csv", row.names=FALSE)

# suppliers <- read.csv("sql/suppliers.csv", check.names = FALSE)
# fctr.cols <- sapply(suppliers, is.factor)
# int.cols <- sapply(suppliers, is.integer)
# suppliers[, fctr.cols] <- sapply(suppliers[, fctr.cols], as.character)
# suppliers[, int.cols] <- sapply(suppliers[, int.cols], as.numeric)
# save(suppliers, file = "sql/suppliers.rdata")

# write.csv(parts, "sql/parts.csv", row.names=FALSE)

# parts <- read.csv("sql/parts.csv", check.names = FALSE)
# fctr.cols <- sapply(parts, is.factor)
# int.cols <- sapply(parts, is.integer)
# parts[, fctr.cols] <- sapply(parts[, fctr.cols], as.character)
# parts[, int.cols] <- sapply(parts[, int.cols], as.numeric)
# save(parts, file = "sql/parts.rdata")

input=inner_join(parts,catalog)%>% inner_join(suppliers)
write.csv(input, "data-raw/s14_input1.csv", row.names=FALSE)
s14_input1 <- read.csv("data-raw/s14_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s14_input1, is.factor)
int.cols <- sapply(s14_input1, is.integer)
s14_input1[, fctr.cols] <- sapply(s14_input1[, fctr.cols], as.character)
s14_input1[, int.cols] <- sapply(s14_input1[, int.cols], as.numeric)
save(s14_input1, file = "data/s14_input1.rdata")

output=input %>% group_by(sname) %>% summarise(n=n()) %>% filter(n == max(n)) %>% select(sname)
write.csv(output, "data-raw/s14_output1.csv", row.names=FALSE)
s14_output1 <- read.csv("data-raw/s14_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s14_output1, is.factor)
int.cols <- sapply(s14_output1, is.integer)
s14_output1[, fctr.cols] <- sapply(s14_output1[, fctr.cols], as.character)
s14_output1[, int.cols] <- sapply(s14_output1[, int.cols], as.numeric)
save(s14_output1, file = "data/s14_output1.rdata")

# 5.2.2
inner_join(parts,catalog) %>% inner_join(suppliers) %>% group_by(sname) %>% summarise(n=n()) %>% filter(n == max(n)) %>% select(sname)