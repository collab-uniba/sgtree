pl <- function(dir, csv, xlab, ylab, outfile) {
	library("poweRlaw")
	setwd(dir)

	#read data from csv that has one column with frequency
	data1 <- read.csv(csv)
	#extract data from the column to vector
	data2 <- data1[[1]]

	#create a discrete power law object
	d = displ$new(data2)
	#estimate lower bound
	est = estimate_xmin(d)
	d$setXmin(est)

	par(bg="white")
	#show a log-log plot of the data
	#On the x axis there are values of comments
	#On the y axis there are CDF (Cumulative Distribution Function), that represents 
	#the probability that the random variable X takes on a value less than or equal to x
	plot(d, xlab=xlab, ylab=ylab, bg="white")
	#Add in the fitted distribution
	lines(d, col=2)

	#print data
	par(mar=c(1,1,1,1))
	#quartz.save(file=paste("PL ", name, " ", type, ".png", sep=""), dpi=720)
	quartz.save(file=outfile, dpi=720)
	dev.off()
}

pl("~/Dropbox (Università)/Cartella del team Università/Risultati/Complessivi/", "generale degree.tsv", "Degree", "CDF (Cumulative Distribution Function)", "png/PL generale degree.png")