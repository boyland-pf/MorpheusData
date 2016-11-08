# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
catalog <- read.table(text=
"supplier_key part_id
S1 P1
S1 P4
S2 P2
S2 P3
S3 P5", header=T)

parts <- read.table(text=
"part_id part_name
P1 PN1
P2 PN2
P3 PN3
P4 PN4
P5 PN5
P6 PN6
P7 PN7", header=T)

# write.csv(catalog, "sql/catalog.csv", row.names=FALSE)

# catalog <- read.csv("sql/catalog.csv", check.names = FALSE)
# fctr.cols <- sapply(catalog, is.factor)
# int.cols <- sapply(catalog, is.integer)
# catalog[, fctr.cols] <- sapply(catalog[, fctr.cols], as.character)
# catalog[, int.cols] <- sapply(catalog[, int.cols], as.numeric)
# save(catalog, file = "sql/catalog.rdata")

# write.csv(parts, "sql/parts.csv", row.names=FALSE)

# parts <- read.csv("sql/parts.csv", check.names = FALSE)
# fctr.cols <- sapply(parts, is.factor)
# int.cols <- sapply(parts, is.integer)
# parts[, fctr.cols] <- sapply(parts[, fctr.cols], as.character)
# parts[, int.cols] <- sapply(parts[, int.cols], as.numeric)
# save(parts, file = "sql/parts.rdata")

input=inner_join(parts,catalog)
write.csv(input, "data-raw/s13_input1.csv", row.names=FALSE)
s13_input1 <- read.csv("data-raw/s13_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s13_input1, is.factor)
int.cols <- sapply(s13_input1, is.integer)
s13_input1[, fctr.cols] <- sapply(s13_input1[, fctr.cols], as.character)
s13_input1[, int.cols] <- sapply(s13_input1[, int.cols], as.numeric)
save(s13_input1, file = "data/s13_input1.rdata")

output=input %>% select(part_name)
write.csv(output, "data-raw/s13_output1.csv", row.names=FALSE)
s13_output1 <- read.csv("data-raw/s13_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s13_output1, is.factor)
int.cols <- sapply(s13_output1, is.integer)
s13_output1[, fctr.cols] <- sapply(s13_output1[, fctr.cols], as.character)
s13_output1[, int.cols] <- sapply(s13_output1[, int.cols], as.numeric)
save(s13_output1, file = "data/s13_output1.rdata")

# 5.2.1
inner_join(parts,catalog) %>% select(part_name)