setwd("Dropbox (Personale)/Songtree/2. Degree distribution/Altro/")
data = read.csv("CSV/Out-degree and weighted out-degree.csv", sep="\t")

#PLOT Authors
#seleziona solo gli autori in quanto solo loro possono ricevere commenti
d = data[data$songs_written != 0, ]
d$outdegree = d$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
fx <- table(d$outdegree)
i <- as.numeric(names(fx))
par(bg="white")
plot(i, fx, log="xy", xlab="Out Degree", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
quartz.save(file="QUANTILEPLOT authors outdegree.png", dpi=720)
dev.off()

#PLOT Non Authors
#seleziona solo gli autori in quanto solo loro possono ricevere commenti
d = data[data$songs_written == 0, ]
d$outdegree = d$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
fx <- table(d$outdegree)
i <- as.numeric(names(fx))
par(bg="white")
plot(i, fx, log="xy", xlab="Out Degree", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
quartz.save(file="QUANTILEPLOT non_authors outdegree.png", dpi=720)
dev.off()

#PLOT Active users
d1 = read.csv("CSV/ID_active_users.tsv")
d = merge(data, d1, by = "id")
d$outdegree = d$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
fx <- table(d$outdegree)
i <- as.numeric(names(fx))
par(bg="white")
plot(i, fx, log="xy", xlab="Out Degree", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
quartz.save(file="QUANTILEPLOT active_users outdegree.png", dpi=720)
dev.off()

#PLOT Commenters non authors
d1 = read.csv("CSV/ID_commenters_non_authors.tsv")
d = merge(data, d1, by = "id")
d$outdegree = d$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
fx <- table(d$outdegree)
i <- as.numeric(names(fx))
par(bg="white")
plot(i, fx, log="xy", xlab="Out Degree", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
quartz.save(file="QUANTILEPLOT commenters_non_author outdegree.png", dpi=720)
dev.off()

#######################################################################################################

library("poweRlaw")

#PLOT Authors
data1 = data[data$songs_written != 0, ]
data1$outdegree = data1$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
data2 = data1$outdegree
d = displ$new(data2)
est = estimate_xmin(d)
d$setXmin(est)
par(bg="white")
plot(d, xlab="Out Degree", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1$outdegree)))
lines(d, col=2)
quartz.save(file="PL authors outdegree.png", dpi=720)
dev.off()

#PLOT Non Authors
data1 = data[data$songs_written == 0, ]
data1$outdegree = data1$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
data2 = data1$outdegree
d = displ$new(data2)
est = estimate_xmin(d)
d$setXmin(est)
par(bg="white")
plot(d, xlab="Out Degree", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1$outdegree)))
lines(d, col=2)
quartz.save(file="PL non_authors outdegree.png", dpi=720)
dev.off()

#PLOT Active users
d1 = read.csv("CSV/ID_active_users.tsv")
data1 = merge(data, d1, by = "id")
data1$outdegree = data1$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
data2 = data1$outdegree
d = displ$new(data2)
est = estimate_xmin(d)
d$setXmin(est)
par(bg="white")
plot(d, xlab="Out Degree", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1$outdegree)))
lines(d, col=2)
quartz.save(file="PL active_users outdegree.png", dpi=720)
dev.off()

#PLOT Commenters non authors
d1 = read.csv("CSV/ID_commenters_non_authors.tsv")
data1 = merge(data, d1, by = "id")
data1$outdegree = data1$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
data2 = data1$outdegree
d = displ$new(data2)
est = estimate_xmin(d)
d$setXmin(est)
par(bg="white")
plot(d, xlab="Out Degree", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1$outdegree)))
lines(d, col=2)
quartz.save(file="PL commenters_non_authors outdegree.png", dpi=720)
dev.off()