loglogPlot <- function(dir, filename, genre) {
  library("poweRlaw")
  
  setwd(dir)
  data = read.csv(paste("CSV/", filename, sep=""), sep="\t")
  
  #seleziona solo gli autori in quanto solo loro possono ricevere commenti
  data1 = data[data$songs_written != 0, ]
  data1 <- na.omit(data1)  #per i file CSV dei generi toglie i valori N\A dei commentatori non autori, non fa nulla per il file CSV di GENERALE
  data1$indegree = data1$indegree + 1 #per evitare che i valori pari a 0 vengano ignorati
  data2 = data1$indegree
  d = displ$new(data2)
  est = estimate_xmin(d)
  d$setXmin(est)
  par(bg="white")
  plot(d, xlab="In Degree", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1$indegree)))
  lines(d, col=2)
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("PL", genre, "indegree.png"), dpi=720)
  dev.off()
  
  data$outdegree = data$outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
  data1 = data$outdegree
  d = displ$new(data1)
  est = estimate_xmin(d)
  d$setXmin(est)
  par(bg="white")
  plot(d, xlab="Out Degree", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1)))
  lines(d, col=2)
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("PL", genre, "outdegree.png"), dpi=720)
  dev.off()
  
  #seleziona solo gli autori in quanto solo loro possono ricevere commenti
  data1 = data[data$songs_written != 0, ]
  data1 <- na.omit(data1)  #per i file CSV dei generi toglie i valori N\A dei commentatori non autori, non fa nulla per il file CSV di GENERALE
  data1$weighted.indegree = data1$weighted.indegree + 1 #per evitare che i valori pari a 0 vengano ignorati
  data2 = data1$weighted.indegree
  d = displ$new(data2)
  est = estimate_xmin(d)
  d$setXmin(est)
  par(bg="white")
  plot(d, xlab="Number of Comments received", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1$weighted.indegree)))
  lines(d, col=2)
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("PL", genre, "comments received.png"), dpi=720)
  dev.off()
  
  data$weighted.outdegree = data$weighted.outdegree + 1 #per evitare che i valori pari a 0 vengano ignorati
  data1 = data$weighted.outdegree
  d = displ$new(data1)
  est = estimate_xmin(d)
  d$setXmin(est)
  par(bg="white")
  plot(d, xlab="Number of Comments sent", ylab="CDF (Cumulative Distribution Function)", bg="white", sub=paste("n =", length(data1)))
  lines(d, col=2)
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("PL", genre, "comments sent.png"), dpi=720)
  dev.off()
  
}

directories = c("Entire/", 
                "Generi/ALTERNATIVE E ELECTRONIC/", 
                "Generi/HIP HOP E R&B/", 
                "Generi/JAZZ E CLASSICAL/", 
                "Generi/ROCK E BLUES/")

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

for(i in 1:length(directories)) {
  dir = paste("~/Dropbox (Personale)/Songtree/2. Power Law/", directories[i], sep="")
  file = filenames[i]
  loglogPlot(dir, file, genres[i])
}