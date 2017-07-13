spearman2 <- function(dir, csv, xlab, ylab) {
	setwd(dir)
	data = read.csv(paste("CSV/", csv, ".tsv", sep=""), sep="\t", header=TRUE)

	#labels = names(data)

	#trova righe dove ci sono zeri e le elimina
	#row_sub = apply(data, 1, function(row) all(row !=0))
	#data = data[row_sub,]

	#calcolo indice di pearson
	sub = paste("Spearman's correlation = ", cor(data, method="spearman"))

	par(bg="white")
	#plot(data, log="xy", xlab=labels[1], ylab=labels[2], sub=sub[2], bg="white")
	plot(data, log="xy", xlab=xlab, ylab=ylab, sub=sub[2], bg="white")
	par(mar=c(1,1,1,1))
	quartz.save(file=paste(csv, ".png", sep=""), dpi=400)
	dev.off()
}

files=c("1 Corr Comments sent - Songs",
	"2 Corr Comments sent - New Songs",
	"3 Corr Comments sent - Overdubs")

ylab = c("Songs written",
	"New Songs written",
	"Overdubs written")

for(i in 1: length(files)) {
	spearman2("~/Dropbox (Università)/Cartella del team Università/Risultati/5. Activity correlation/Generale", paste("GENERAL", files[i]), "Numbers of Comments sent", ylab[i])
}

types=c("ROCK", "HIPHOP", "ACOUSTIC")
for(j in 1:length(types)) {
	for(i in 1: length(files)) {
		spearman2("~/Dropbox (Università)/Cartella del team Università/Risultati/5. Activity correlation/Generi", paste(types[j], files[i]), "Numbers of Comments sent", ylab[i])
	}
}

#------------------------------------------------------------------------------------
files2 = c("1 Corr Songs - New Songs",
		"2 Corr Songs - Overdubs",
		"3 Corr Songs - In Degree",
		"4 Corr Songs - Out Degree",
		"5 Corr Songs - Betweenness",
		"6 Corr New Songs - Overdubs",
		"7 Corr New Songs - Norm. In Degree",
		"8 Corr New Songs - Norm. Out Degree",
		"9 Corr New Songs - Betweeness",
		"10 Corr Overdubs - Norm. In Degree",
		"11 Corr Overdubs - Norm. Out Degree",
		"12 Corr Overdubs - Betweenness",
		"13 Corr In Degree - Out Degree",
		"14 Corr In Degree - Betweenness",
		"15 Corr Out Degree - Betweenness")

xlab2 = c("Songs",
		"Songs",
		"Songs",
		"Songs",
		"Songs",
		"New Songs",
		"New Songs",
		"New Songs",
		"New Songs",
		"Overdubs",
		"Overdubs",
		"Overdubs",
		"In Degree",
		"In Degree",
		"Out Degree")

ylab2 = c("New Songs",
		"Overdubs",
		"In Degree",
		"Out Degree",
		"Betweenness",
		"Overdubs",
		"In Degree",
		"Out Degree",
		"Betweeness",
		"In Degree",
		"Out Degree",
		"Betweenness",
		"Out Degree",
		"Betweenness",
 		"Betweenness")

for(i in 1: length(files2)) {
	spearman2("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/Generale", paste("GENERALE", files2[i]), xlab2[i], ylab2[i])
}

types2=c("ROCK", "HIPHOP", "ACOUSTIC")
for(j in 1:length(types2)) {
	for(i in 1: length(files2)) {
		spearman2("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/Generi", paste(types2[j], files2[i]), xlab2[i], ylab2[i])
	}
}