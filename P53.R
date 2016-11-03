# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 53
MemberID <- c(123,123,234,234)
nbin <- 4
imatrix <- matrix(sample(c(0,1), size=nbin * length(MemberID), replace=TRUE), 
                  nrow=length(MemberID))
colnames(imatrix) <- letters[1:nbin]
years <- c("Y1","Y2","Y1","Y2")

dat <- data.frame(cbind(MemberID, years, imatrix))


write.csv(dat, "data-raw/p53_input1.csv", row.names=FALSE)

df_out = dat %>%
    gather(Var, Val, a:d) %>% 
     unite(yearsVar, years, Var) %>%
     spread(yearsVar, Val)

write.csv(df_out, "data-raw/p53_output1.csv", row.names=FALSE)

p53_output1 <- read.csv("data-raw/p53_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p53_output1, is.factor)
int.cols <- sapply(p53_output1, is.integer)

p53_output1[, fctr.cols] <- sapply(p53_output1[, fctr.cols], as.character)
p53_output1[, int.cols] <- sapply(p53_output1[, int.cols], as.numeric)
save(p53_output1, file = "data/p53_output1.rdata")

p53_input1 <- read.csv("data-raw/p53_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p53_input1, is.factor)
int.cols <- sapply(p53_input1, is.integer)

p53_input1[, fctr.cols] <- sapply(p53_input1[, fctr.cols], as.character)
p53_input1[, int.cols] <- sapply(p53_input1[, int.cols], as.numeric)
save(p53_input1, file = "data/p53_input1.rdata")
