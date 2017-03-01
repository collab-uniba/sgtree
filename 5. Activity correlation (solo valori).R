activityCorrelationTable <- function(dir) {
	files = c("1 Corr Songs - New Songs",
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


	for(i in 1:length(files)) {
		data = read.csv(paste(dir, "Generale/CSV/", "GENERALE ", files[i], ".tsv", sep=""), sep="\t", header=TRUE)
		correlazione = cor(data, method="spearman")
		print(paste("GENERALE ", files[i], " = ", correlazione[2], sep=""))
	}

	types=c("ROCK", "HIPHOP", "ACOUSTIC")
	for(j in 1:length(types)) {
		for(i in 1: length(files)) {
			data = read.csv(paste(dir, "Generi/CSV/", types[j], " ", files[i], ".tsv", sep=""), sep="\t", header=TRUE)
			correlazione = cor(data, method="spearman")
			print(paste(types[j], " ", files[i], " = ", correlazione[2], sep=""))		
		}
	}
}

activityCorrelationTable("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/")