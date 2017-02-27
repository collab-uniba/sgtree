loglogPlot <- function(dir, name, type) {
	library("poweRlaw")
	setwd(dir)

	#read data from csv that has one column with frequency
	data1 <- read.csv(paste(name, " ", type, ".tsv", sep=""))
	#extract data from the column to vector
	data2 <- data1[[1]]

	#create a discrete power law object
	d = displ$new(data2)
	#estimate lower bound
	est = estimate_xmin(d)
	d$setXmin(est)

	#show a log-log plot of the data
	#On the x axis there are values of comments
	#On the y axis there are CDF (Cumulative Distribution Function), that represents 
	#the probability that the random variable X takes on a value less than or equal to x
	par(bg="white")
	types = c("indegree", "outdegree", "received comments", "sent comments")
	if (identical(type, types[1])) {
		plot(d, xlab="In Degree", ylab="CDF (Cumulative Distribution Function)", bg="white")
	} else if (identical(type, types[2])) {
		plot(d, xlab="Out Degree", ylab="CDF (Cumulative Distribution Function)", bg="white")
	} else if (identical(type, types[3])) {
		plot(d, xlab="Number of received Comments", ylab="CDF (Cumulative Distribution Function)", bg="white")
	} else {
		plot(d, xlab="Number of sent Comments", ylab="CDF (Cumulative Distribution Function)", bg="white")
	}
	#Add in the fitted distribution
	lines(d, col=2)
	
	#print data
	par(mar=c(1,1,1,1))
	quartz.save(file=paste("png/", "PL ", name, " ", type, ".png", sep=""), dpi=720)
	dev.off()
}

directories = c("Complessivi/", 
	"Generi/Acoustic/", 
	"Generi/Alternative/", 
	"Generi/Electronic/", 
	"Generi/Hip Hop/", 
	"Generi/Pop/", 
	"Generi/Rock/")
names = c("generale", 
	"acoustic", 
	"alternative", 
	"electronic", 
	"hh", 
	"pop", 
	"rock")
types = c("indegree", 
	"outdegree", 
	"received comments", 
	"sent comments")

for(j in 1:length(directories)) {
	for(i in 1:length(types)) {
		loglogPlot(paste("~/Dropbox (Università)/Cartella del team Università/Risultati/", directories[j], sep=""), names[j], types[i])
	}
}