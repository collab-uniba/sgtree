meanMinMax <- function (dir, csv, last) {
	setwd(dir)
	data = read.csv(paste("CSV/", csv, ".tsv", sep="") , header=TRUE, sep="\t")

	#trova righe dove ci sono zeri e le elimina
	#row_sub = apply(data, 1, function(row) all(row !=0))
	#data = data[row_sub,]
	
	data <- setNames(data, LETTERS[1:2])
	if(last) {
		data1 = as.vector(t(data$A))
		print(csv)
		print(paste("Mean = ", mean(data1)))
		print(paste("Min = ", min(data1)))
		print(paste("Max = ", max(data1)))

		data2 = as.vector(t(data$B))
		print(csv)
		print(paste("Mean = ", mean(data2)))
		print(paste("Min = ", min(data2)))
		print(paste("Max = ", max(data2)))
	} else {
		data1 = as.vector(t(data$A))
		print(csv)
		print(paste("Mean = ", mean(data1)))
		print(paste("Min = ", min(data1)))
		print(paste("Max = ", max(data1)))
	}
}

files = c("1 Corr Songs - New Songs",
		"6 Corr New Songs - Overdubs",
		"10 Corr Overdubs - Norm. In Degree",
		"13 Corr In Degree - Out Degree",
		"15 Corr Out Degree - Betweenness")

for(i in 1:length(files)) {
	if(i != length(files)) {
		meanMinMax("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/Generale/", paste("GENERALE", files[i]), FALSE)
	} else {
		meanMinMax("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/Generale/", paste("GENERALE", files[i]), TRUE)
	}
}

types=c("ROCK", "HIPHOP", "ACOUSTIC")
for(j in 1:length(types)) {
	for(i in 1: length(files)) {
		if(i != length(files)) {
			meanMinMax("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/Generi/", paste(types[j], files[i]), FALSE)
		} else {
			meanMinMax("~/Dropbox (Università)/Cartella del team Università/Risultati/7. Cross correlation table/Generi/", paste(types[j], files[i]), TRUE)
		}
	}
}