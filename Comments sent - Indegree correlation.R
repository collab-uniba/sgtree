spearman <- function(dir, name) {
	setwd(dir)
	data = read.csv(paste(name, " correlazione.tsv", sep=""), sep="\t", header=TRUE)

	#trova righe dove ci sono zeri e le elimina
	row_sub = apply(data, 1, function(row) all(row !=0 ))
	data = data[row_sub,]

	#calcolo indice di pearson
	sub = paste("Spearman's correlation = ", cor(data, method="spearman"))

	par(bg="white")
	plot(data$weighted.outdegree, data$indegree, log="xy", xlab="Comments Sent", ylab="In degree", sub=sub[2], bg="white")
	par(mar=c(1,1,1,1))
	quartz.save(file=paste("png/","COR ", name, " correlazione.png", sep=""), dpi=1024)
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

for(i in 1: length(directories)) {
	spearman(paste("~/Dropbox (Università)/Cartella del team Università/Risultati/", directories[i], sep=""), names[i])
}