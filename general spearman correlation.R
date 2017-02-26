spearman1 <- function(dir, csv, xlab, ylab, outfilename) {
	setwd(dir)
	data = read.csv(csv, sep="\t", header=TRUE)

	#trova righe dove ci sono zeri e le elimina
	row_sub = apply(data, 1, function(row) all(row !=0))
	data = data[row_sub,]

	#calcolo indice di pearson
	sub = paste("Spearman's correlation = ", cor(data, method="spearman"))

	plot(data, log="xy", xlab=xlab, ylab=ylab, sub=sub[2])
	par(mar=c(1,1,1,1))
	quartz.save(file=outfilename, dpi=1024)
	dev.off()
}

spearman2 <- function(dir, csv) {
	setwd(dir)
	data = read.csv(csv, sep="\t", header=TRUE)

	labels = names(data)

	#trova righe dove ci sono zeri e le elimina
	row_sub = apply(data, 1, function(row) all(row !=0))
	data = data[row_sub,]

	#calcolo indice di pearson
	sub = paste("Spearman's correlation = ", cor(data, method="spearman"))

	plot(data, log="xy", xlab=labels[1], ylab=labels[2], sub=sub[2])
	par(mar=c(1,1,1,1))
	quartz.save(file=paste("png (with 0 values)/", csv, "(with 0).png", sep=""), dpi=400)
	dev.off()
}

files=c("0.1 Corr Comments sent - Songs.tsv",
	"0.2 Corr Comments sent - New Songs.tsv",
	"0.3 Corr Comments sent - Overdubs.tsv",
	"1. Corr Songs - New Songs.tsv",
	"2. Corr Songs - Overdubs.tsv",
	"3. Corr Songs - Normalized Out Degree.tsv",
	"4. Corr Songs - Normalized In Degree.tsv",
	"5. Corr Songs - Betweeness.tsv",
	"6. Corr New Songs - Overdubs.tsv",
	"7. Corr New Songs - Normalized Out Degree.tsv",
	"8. Corr New Songs - Normalized In Degree.tsv",
	"9. Corr New Songs - Betweeness.tsv",
	"10. Corr Overdubs - Normalized Out Degree.tsv",
	"11. Corr Overdubs - Normalized In Degree.tsv",
	"12. Corr Overdubs - Betweeness.tsv",
	"13. Corr In Degree - Out Degree.tsv",
	"14. Corr Out Degree - Betweeness.tsv",
	"15. Corr In Degree - Betweeness.tsv")

for(i in 1: length(files)) {
	spearman2("~/Dropbox (Università)/Cartella del team Università/Risultati/Activity correlation/", files[i])
}