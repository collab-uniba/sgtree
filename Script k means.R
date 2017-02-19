
mydata <- read.csv("commenti inviati.tsv")
# K-Means Cluster Analysis
fit <- kmeans(mydata, 18) # 5 cluster solution

# get cluster means 
#aggregate(mydata,by=list(fit$cluster),FUN=mean)

# append cluster assignment
#mydata1 <- data.frame(mydata, fit$cluster)

#group data based on max value for every cluster
mydata1 = aggregate(mydata, by=list(fit$cluster), FUN=max)
#order data by maximum_sent_comments to create class for frequency calc 
mydata1 = mydata1[order(mydata1$comments),]
classes = mydata1$comments
classes = append(classes, 0:1, after=0)
t = table(cut(mydata[[1]],classes))
X <- vector(mode="integer", length=length(classes)-1)
X[1]=1
#classes[1]=1
for (i in 3:(length(classes)-1)) {
	X[i-1] = classes[i-1]+((classes[i]-classes[i-1])/2)
}
X[length(classes)-1]=classes[length(classes)]

#X = X[-1]
dataf = data.frame(x=X, y=as.vector(t))
plot(dataf, log="xy", xlab="Commenti inviati", ylab="Numero di utenti")