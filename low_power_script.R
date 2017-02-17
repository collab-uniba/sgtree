library("poweRlaw")
setwd("~/Desktop")

#read data from csv that has one column with frequency
data1 <- read.csv("file.tsv")
#extract data from the column to vector
data2 <- data1[[1]]

#create a discrete power law object
d = displ$new(data2)
#estimate lower bound
est = estimate_xmin(d)
d$setXmin(est)

#show a log-log plot of the data
plot1 = plot(d, xlab="Numero di commenti", ylab="Numero di utenti")
#Add in the fitted distribution
lines(d, col=2)

#shows data of the plot
#head(plot1, 100)