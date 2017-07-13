quantilePlot <- function(dir, filename, genre) {
  setwd(dir)
  data = read.csv(paste("CSV/", filename, sep=""), sep="\t")
  
  #sono inclusi solo coloro che hanno degree almeno pari a 1
  d = data
  fx <- table(d$indegree)
  i <- as.numeric(names(fx))
  par(bg="white")
  plot(i, fx, log="xy", xlab="In Degree", ylab="Number of users", sub=paste("n =", length(d$indegree)))
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT", genre, "indegree.png"), dpi=720)
  dev.off()
  
  d = data
  fx <- table(d$outdegree)
  i <- as.numeric(names(fx))
  par(bg="white")
  plot(i, fx, log="xy", xlab="Out Degree", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT", genre, "outdegree.png"), dpi=720)
  dev.off()
  
  #seleziona solo gli autori in quanto solo loro possono ricevere commenti
  d = data
  fx <- table(d$weighted.indegree)
  i <- as.numeric(names(fx))
  par(bg="white")
  plot(i, fx, log="xy", xlab="Number of Overdubs received", ylab="Number of users", sub=paste("n =", length(d$weighted.indegree)))
  #par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT", genre, "weighted indegree.png"), dpi=720)
  dev.off()
  
  d = data
  fx <- table(d$weighted.outdegree)
  i <- as.numeric(names(fx))
  par(bg="white")
  plot(i, fx, log="xy", xlab="Number of Overdubs made", ylab="Number of users", sub=paste("n =", length(d$weighted.outdegree)))
  #par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT", genre, "weighted outdegree.png"), dpi=720)
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

filenames = c("Overdub Graph [Nodes].csv",
              "Overdub graph macro genres - AlternativeElectronic [Nodes].csv",
              "Overdub graph macro genres - HipHopRnB [Nodes].csv",
              "Overdub graph macro genres - JazzClassical [Nodes].csv",
              "Overdub graph macro genres - RockBlues [Nodes].csv")

for(i in 1:length(directories)) {
  dir = paste("~/Dropbox (Personale)/Songtree/3. Overdub Graph/", directories[i], sep="")
  file = filenames[i]
  quantilePlot(dir, file, genres[i])
}