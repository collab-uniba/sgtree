quantilePlot <- function(dir, filename1,  filename2,  xlab) {
  setwd(dir)
  data2 = read.csv(paste("CSV/", filename1, " ", filename2, ".tsv", sep=""), sep="\t")
  fx <- table(data2)
  i <- as.numeric(names(fx))
  
  par(bg="white")
  plot(i, fx, log="xy", xlab=xlab, ylab="Number of users")
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT ", filename1, " ", filename2, ".png", sep=""), dpi=720)
  dev.off()
}

directories = c("Entire/", 
                "Generi/Acoustic/", 
                "Generi/Alternative/", 
                "Generi/Electronic/", 
                "Generi/Hip Hop/", 
                "Generi/Pop/", 
                "Generi/Rock/")

filename1 = c("generale", 
          "acoustic", 
          "alternative", 
          "electronic", 
          "hh", 
          "pop", 
          "rock")

filename2 = c("indegree", 
          "outdegree", 
          "received comments", 
          "sent comments")

xlabs = c("In Degree",
          "Out Degree",
          "Number of received Comments",
          "Number of sent Comments")

for(j in 1:length(directories)) {
  dir = paste("~/Dropbox (Personale)/Songtree/2. Power Law/", directories[j], sep="")
  for(i in 1:length(filename2)) {
    quantilePlot(dir, filename1[j], filename2[i], xlabs[i])
  }
}