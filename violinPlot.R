violinplot <- function (dir, genre, file, xlab) {
	setwd(dir)
	library(vioplot)
	data = read.csv(paste(dir, "CSV/", genre, " ", file, ".tsv", sep=""))
	datalog = log(data)

	par(bg = "white")
	vioplot(datalog$column, names=xlab, col="light blue")

	par(mar=c(1,1,1,1))
	quartz.save(file=paste(genre, " ",  file, ".png", sep=""), dpi=400)
	dev.off()
}

files = c("comments_received",
		"comments_sent",
		"songs_written",
		"new_songs_written",
		"overdubs_written")

xlabs = c("Comments received",
		"Comments sent",
		"Songs written",
		"New Songs written",
		"Overdubs written")

for (i in 1:length(files)) {
	violinplot("~/Dropbox (Università)/Cartella del team Università/Risultati/9. Statistiche/Violin Plot/Generale/", "GENERALE", files[i], xlabs[i])
}

genres = c("ROCK", "ACOUSTIC", "HIPHOP")

for (i in 1:length(genres)) {
	for (j in 1:length(files)) {
		violinplot("~/Dropbox (Università)/Cartella del team Università/Risultati/9. Statistiche/Violin Plot/Generi/", genres[i], files[j], xlabs[j])
	}
}
