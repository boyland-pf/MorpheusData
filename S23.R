# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
catalog <- read.table(text=
"supplier_key part_id cost
S1 P1 2
S1 P2 1
S1 P3 3
S2 P2 2
S2 P4 3
S2 P5 1
S2 P6 2
S3 P2 2
S3 P6 4
S4 P1 3
S4 P2 4
S4 P3 6
S4 P5 2
S5 P1 4
S5 P3 5
S5 P5 1
S5 P6 2
S6 P2 4", header=T)

parts <- read.table(text=
"part_id color pname
P1 yellow PN1
P2 green PN2
P3 red PN3
P4 green PN4
P5 yellow PN5
P6 red PN6", header=T)

suppliers <- read.table(text=
"supplier_key sname
S1 SN1
S2 SN2
S3 SN3
S4 SN4
S5 SN5
S6 SN6", header=T)

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

input=inner_join(parts,catalog) %>% inner_join(suppliers)
write.csv(input, "data-raw/s23_input1.csv", row.names=FALSE)
s23_input1 <- read.csv("data-raw/s23_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s23_input1, is.factor)
int.cols <- sapply(s23_input1, is.integer)
s23_input1[, fctr.cols] <- sapply(s23_input1[, fctr.cols], as.character)
s23_input1[, int.cols] <- sapply(s23_input1[, int.cols], as.numeric)
save(s23_input1, file = "data/s23_input1.rdata")


df1=input %>% 
    filter(color == "green") %>%
    select(sname)
df2=input %>%
    filter(color == "red") %>%
    select(sname)
df3=intersect(df1,df2)
# until here is question 5.2.8
output=input %>% group_by(sname,pname) %>% summarize(n = max(cost)) %>% filter(n == max(n)) %>% inner_join(df3)
write.csv(output, "data-raw/s23_output1.csv", row.names=FALSE)
s23_output1 <- read.csv("data-raw/s23_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s23_output1, is.factor)
int.cols <- sapply(s23_output1, is.integer)
s23_output1[, fctr.cols] <- sapply(s23_output1[, fctr.cols], as.character)
s23_output1[, int.cols] <- sapply(s23_output1[, int.cols], as.numeric)
save(s23_output1, file = "data/s23_output1.rdata")

# 5.2.11
#the output table on the sql paper is wrong!
input=inner_join(parts,catalog) %>% inner_join(suppliers)
df1=input %>% 
    filter(color == "green") %>%
    select(sname)
df2=input %>%
    filter(color == "red") %>%
    select(sname)
df3=intersect(df1,df2)
# until here is question 5.2.8
input %>% 
group_by(sname,pname) %>% 
summarize(n = max(cost)) %>% 
filter(n == max(n)) %>%
# merge the solution from 5.2.8 with 5.2.11
inner_join(df3)



