meanMinMax <- function (dir, csv) {
	setwd(dir)
	data = read.csv(csv, header=TRUE)

	#trova righe dove ci sono zeri e le elimina
	row_sub = apply(data, 1, function(row) all(row !=0))
	data = data[row_sub,]
	
	data1 = as.vector(t(data))
	print(csv)
	print(mean(data1))
	print(min(data1))
	print(max(data1))
}

files = c("Stat Songs.tsv",
	"Stat New Songs.tsv",
	"Stat Overdubs.tsv",
	"Stat Out Degree.tsv",
	"Stat In Degree.tsv",
	"Stat Betweeness.tsv")

for(i in 1:length(files)) {
	meanMinMax("~/Dropbox (Università)/Cartella del team Università/Risultati/Activity correlation/", files[i])
}