setwd("~/Dropbox (Personale)/Songtree/2. Power Law/Entire/CSV")
plots = function(file, xlab) {
  data2 = read.csv(file, sep="\t")
  fx <- table(data2)
  i <- as.numeric(names(fx))
  
  par(bg="white")
  plot(i, fx, log="xy", xlab=xlab, ylab="Number of users")
  par(mar=c(1,1,1,1))
  quartz.save(file=paste("QUANTILEPLOT Generale ", xlab, ".png", sep=""), dpi=720)
  dev.off()
}

files = c("generale indegree.tsv", 
          "generale outdegree.tsv", 
          "generale received comments.tsv",
          "generale sent comments.tsv")

xlabs = c("In Degree",
          "Out Degree",
          "Number of received Comments",
          "Number of sent Comments")

for(i in 1:length(files)) {
  plots(files[i], xlabs[i]) 
}


