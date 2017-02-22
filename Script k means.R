quantilePlot <- function(dir, name, type) {
	setwd(dir)

	mydata <- read.csv(paste(name, " ", type, ".tsv", sep=""))
	# K-Means Cluster Analysis
	fit <- kmeans(mydata, 10) # 5 cluster solution

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

	types = c("indegree", "outdegree", "received comments", "sent comments")
	if (identical(type, types[1])) {
		plot(dataf, log="xy", xlab="In Degree", ylab="Number of Users")
	} else if (identical(type, types[2])) {
		plot(dataf, log="xy", xlab="Out Degree", ylab="Number of Users")
	} else if (identical(type, types[3])) {
		plot(dataf, log="xy", xlab="Number of received Comments", ylab="Number of Users")
	} else {
		plot(dataf, log="xy", xlab="Number of sent Comments", ylab="Number of Users")
	}

	par(mar=c(1,1,1,1))
	quartz.save(file=paste("QQ ", name, " ", type, ".png", sep=""), dpi=720)
	dev.off()
}

directories = c("Complessivi/", "Generi/Acoustic/", "Generi/Alternative/", "Generi/Electronic/", "Generi/Hip Hop/", "Generi/Pop/", "Generi/Rock/")
names = c("generale", "acoustic", "alternative", "electronic", "hh", "pop", "rock")
types = c("indegree", "outdegree", "received comments", "sent comments")

for(j in 1:length(directories)) {
	for(i in 1:length(types)) {
		quantilePlot(paste("~/Dropbox (Università)/Cartella del team Università/Risultati/", directories[j], sep=""), names[j], types[i])
	}
}