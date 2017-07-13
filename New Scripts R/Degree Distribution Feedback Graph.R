quantilePlot <- function(dir, filename, genre) {
    setwd(dir)
    data = read.csv(paste("CSV/", filename, sep=""), sep="\t")
    
    #seleziona solo gli autori in quanto solo loro possono ricevere commenti
    d = data[data$songs_written != 0, ]
    d <- na.omit(d)  #per i file CSV dei generi toglie i valori N\A dei commentatori non autori, non fa nulla per il file CSV di GENERALE
    d$indegree = d$indegree + 1 #per evitare che i valori pari a 0 vengano ignorati
    fx <- table(d$indegree)
    i <- as.numeric(names(fx))
    par(bg="white")
    plot(i, fx, log="xy", xlab="In Degree", ylab="Number of users", sub=paste("n =", length(d$indegree)))
    par(mar=c(1,1,1,1))
    quartz.save(file=paste("QUANTILEPLOT", genre, "indegree.png"), dpi=720)
    dev.off()
    
    #seleziona tutta la feedback net (autori + commentatori non autori)
    d = data
    d$outdegree = d$outdegree + 1
    fx <- table(d$outdegree)
    i <- as.numeric(names(fx))
    par(bg="white")
    plot(i, fx, log="xy", xlab="Out Degree", ylab="Number of users", sub=paste("n =", length(d$outdegree)))
    #par(mar=c(1,1,1,1))
    quartz.save(file=paste("QUANTILEPLOT", genre, "outdegree.png"), dpi=720)
    dev.off()
    
    #seleziona solo gli autori in quanto solo loro possono ricevere commenti
    d = data[data$songs_written != 0, ]
    d <- na.omit(d)  #per i file CSV dei generi toglie i valori N\A dei commentatori non autori, non fa nulla per il file CSV di GENERALE
    d$weighted.indegree = d$weighted.indegree + 1
    fx <- table(d$weighted.indegree)
    i <- as.numeric(names(fx))
    par(bg="white")
    plot(i, fx, log="xy", xlab="Number of Comments received", ylab="Number of users", sub=paste("n =", length(d$weighted.indegree)))
    #par(mar=c(1,1,1,1))
    quartz.save(file=paste("QUANTILEPLOT", genre, "comments received.png"), dpi=720)
    dev.off()
    
    #seleziona tutta la feedback net (autori + commentatori non autori)
    d = data
    d$weighted.outdegree = d$weighted.outdegree + 1
    fx <- table(d$weighted.outdegree)
    i <- as.numeric(names(fx))
    par(bg="white")
    plot(i, fx, log="xy", xlab="Number of Comments sent", ylab="Number of users", sub=paste("n =", length(d$weighted.outdegree)))
    #par(mar=c(1,1,1,1))
    quartz.save(file=paste("QUANTILEPLOT", genre, "comments sent.png"), dpi=720)
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
  dir = paste("~/Dropbox (Personale)/Songtree/2. Degree distribution/1. Feedback Graph/", directories[i], sep="")
  file = filenames[i]
  quantilePlot(dir, file, genres[i])
}