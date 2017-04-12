spearman <- function(dir, filename, genre) {
  setwd(dir)
  data = read.csv(paste("CSV/", filename, sep=""), sep="\t")
  
  #seleziona solo autori di CANZONI (overdub e nuove)
  d = data[data$songs_written != 0, ]
  
  #calcolo indice di pearson e disegno del grafico
  sub = paste("Spearman's correlation = ", cor(d$weighted.outdegree, d$songs_written, method="spearman"), ", n = ", length(d$weighted.outdegree), sep="")
  par(bg="white")
  plot(d$weighted.outdegree, d$songs_written, log="xy", xlab="Comments Sent", ylab="Songs written", sub=sub[1], bg="white")
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("COR", genre , "Commenti inviati - Scrittura CANZONI.png"), dpi=720)
  dev.off()
  
  #seleziona solo autori di NUOVE CANZONI
  d = data[data$new_songs_written != 0, ]
  
  #calcolo indice di pearson e disegno del grafico
  sub = paste("Spearman's correlation = ", cor(d$weighted.outdegree, d$new_songs_written, method="spearman"), ", n = ", length(d$weighted.outdegree), sep="")
  par(bg="white")
  plot(d$weighted.outdegree, d$new_songs_written, log="xy", xlab="Comments Sent", ylab="New Songs written", sub=sub[1], bg="white")
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("COR", genre , "Commenti inviati - Scrittura NUOVE CANZONI.png"), dpi=720)
  dev.off()
  
  #seleziona solo autori di OVERDUB
  d = data[data$overdubs_written != 0, ]
  
  #calcolo indice di pearson e disegno del grafico
  sub = paste("Spearman's correlation = ", cor(d$weighted.outdegree, d$overdubs_written, method="spearman"), ", n = ", length(d$weighted.outdegree), sep="")
  par(bg="white")
  plot(d$weighted.outdegree, d$overdubs_written, log="xy", xlab="Comments Sent", ylab="Overdubs written", sub=sub[1], bg="white")
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("COR", genre , "Commenti inviati - Scrittura OVERDUB.png"), dpi=720)
  dev.off()
}

genres = c("GENERAL",
           "ALTERNATIVE E ELECTRONIC",
           "HIP HOP E R&B",
           "JAZZ E CLASSICAL",
           "ROCK E BLUES")

filenames = c("Feedback graph 2 (all authors) [Nodes].csv",
              "Feedback graph MacroGeneri 2 - AlternativeElectronic [Nodes].csv",
              "Feedback graph MacroGeneri 2 - HipHopR&B [Nodes].csv",
              "Feedback graph MacroGeneri 2 - JazzClassical [Nodes].csv",
              "Feedback graph MacroGeneri 2 - RockBlues [Nodes].csv")

for(i in 1:length(filenames)) {
  dir = "~/Dropbox (Personale)/Songtree/4. Correlazione Commenti inviati - Scrittura canzoni/"
  spearman(dir, filenames[i], genres[i])
}