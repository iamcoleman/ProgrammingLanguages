setwd("~/_school/_summer18/languages/FinalProject/R/lib")
weightdata <- read.csv("../sample-weight-data-1.csv")
weightdata.colnames <- names(weightdata)
library(ggplot2)
qplot(Days.Elapsed, Weight, data=weightdata)