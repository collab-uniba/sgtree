quantilePlot <- function(dir, filename, genre) {
  setwd(dir)
  data = read.csv(paste("CSV/", filename, sep=""), sep="\t")
  
  #sono inclusi solo coloro che hanno degree almeno pari a 1
  d = data
  fx <- table(d$degree)
  i <- as.numeric(names(fx))
  par(bg="white")
  plot(i, fx, log="xy", xlab="Degree", ylab="Number of users", sub=paste("n =", length(d$degree)))
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT", genre, "degree.png"), dpi=720)
  dev.off()
  
  #seleziona solo gli autori in quanto solo loro possono ricevere commenti
  d = data
  fx <- table(d$weighted.degree)
  i <- as.numeric(names(fx))
  par(bg="white")
  plot(i, fx, log="xy", xlab="Number of Collaborations", ylab="Number of users", sub=paste("n =", length(d$weighted.degree)))
  #par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT", genre, "weighted degree.png"), dpi=720)
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

filenames = c("Collaboration graph [Nodes].csv",
              "Collaboration Graph Macro Generi - Alternative Electronic [Nodes].csv",
              "Collaboration Graph Macro Generi - HipHopRnB [Nodes].csv",
              "Collaboration Graph Macro Generi - JazzClassical [Nodes].csv",
              "Collaboration Graph Macro Generi - RockBlues [Nodes].csv")

for(i in 1:length(directories)) {
  dir = paste("~/Dropbox (Personale)/Songtree/2. Degree distribution/2. Collaboration Graph/", directories[i], sep="")
  file = filenames[i]
  quantilePlot(dir, file, genres[i])
}