setwd("~/Dropbox (Personale)/Songtree/2. Degree distribution/4. Follow Graph/")
data = read.csv("CSV/Follow Graph [Nodes].csv", sep="\t")

d = data
d$indegree = d$indegree + 1
fx <- table(d$indegree)
i <- as.numeric(names(fx))
par(bg="white")
plot(i, fx, log="xy", xlab="In Degree (followers)", ylab="Number of users", sub=paste("n =", length(d$indegree)))
par(mar=c(1,1,1,1))
quartz.save(file="QUANTILEPLOT indegree.png", dpi=720)
dev.off()

d = data
d$outdegree = d$outdegree + 1
fx <- table(d$outdegree)
i <- as.numeric(names(fx))
par(bg="white")
plot(i, fx, log="xy", xlab="Out Degree (followed)", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
par(mar=c(1,1,1,1))
quartz.save(file="QUANTILEPLOT outdegree.png", dpi=720)
dev.off()