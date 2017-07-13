library(data.tree)

cliques <- function(dir, filename) {
  setwd(dir)
  data = read.csv(paste(dir, "CSV/", filename, sep=""), sep="\t")
  data = data[order(data$modularity_class), ]
  data = data[, c("id", "label", "modularity_class")]
  
  data$pathString <- paste("Cliques", data$modularity_class, data$label, sep="/")
  cliquesFeedback <- as.Node(data)
  #print(cliquesFeedback)
  d = ToListSimple(cliquesFeedback, keepOnly="")
  
  for(i in 2:length(d)) {
    len = length(d[[i]])
    if(len == 4) {  #cambiare il valore per avere le cricche di una dimensione
      cat(paste(d[[i]][[1]], "-> "))
      for(j in 2:len) {
        if(j != len) {
          cat(paste(d[[i]][[j]]$name, ", ", sep=""))
        } else {
          cat(d[[i]][[j]]$name)
        }
      }
      cat("\n")
    }
  }
}

filenames = c("Feedback graph 2 - Cliques [Nodes].csv",
              "Collaboration graph - Cliques 2 [Nodes].csv",
              "Overdub Graph - Cliques 2 [Nodes].csv")

directory = "~/Dropbox (Personale)/Songtree/12. Cliques/"

for(i in 1:length(filenames)) {
  cliques(directory, filenames[i])
  cat("\n\n")
}

