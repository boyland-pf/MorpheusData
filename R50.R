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


write.csv(dat, "data-raw/r50_input1.csv", row.names=FALSE)

df_out = dat %>%
    gather(Var, Val, a:d) %>% 
     unite(yearsVar, years, Var) %>%
     spread(yearsVar, Val)

write.csv(df_out, "data-raw/r50_output1.csv", row.names=FALSE)

r50_output1 <- read.csv("data-raw/r50_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r50_output1, is.factor)
int.cols <- sapply(r50_output1, is.integer)

r50_output1[, fctr.cols] <- sapply(r50_output1[, fctr.cols], as.character)
r50_output1[, int.cols] <- sapply(r50_output1[, int.cols], as.numeric)
save(r50_output1, file = "data/r50_output1.rdata")

r50_input1 <- read.csv("data-raw/r50_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r50_input1, is.factor)
int.cols <- sapply(r50_input1, is.integer)

r50_input1[, fctr.cols] <- sapply(r50_input1[, fctr.cols], as.character)
r50_input1[, int.cols] <- sapply(r50_input1[, int.cols], as.numeric)
save(r50_input1, file = "data/r50_input1.rdata")
