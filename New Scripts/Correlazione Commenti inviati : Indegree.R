spearman <- function(dir, filename, genre) {
  setwd(dir)
  data = read.csv(paste("CSV/", filename, sep=""), sep="\t")
  
  #seleziona solo autori e toglie quelli che non hanno ricevuto alcun messaggio 
  d1 = data[data$songs_written != 0, ]
  d1 <- na.omit(d1)  #per i file CSV dei generi toglie i valori N\A dei commentatori non autori, non fa nulla per il file CSV di GENERALE
  d = d1[d1$indegree != 0, ]
  
  #calcolo indice di pearson e disegno del grafico
  sub = paste("Spearman's correlation = ", cor(d$weighted.outdegree, d$indegree, method="spearman"), ", n = ", length(d$indegree), sep="")
  par(bg="white")
  plot(d$weighted.outdegree, d$indegree, log="xy", xlab="Comments Sent", ylab="In degree", sub=sub[1], bg="white")
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("COR", genre , "correlazione.png"), dpi=720)
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
  dir = "~/Dropbox (Personale)/Songtree/3. Correlazione Commenti inviati - In Degree/"
  spearman(dir, filenames[i], genres[i])
}