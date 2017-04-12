crossCorrelation <- function(dir, filename1, filename2, genre) {
  setwd(dir)
  data1 = read.csv(paste("CSV/", filename1, sep=""), sep="\t")
  data2 = read.csv(paste("CSV/", filename2, sep=""), sep="\t")
  data = merge(data1, data2, by = "id")
  
  m = matrix(c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), nrow = 6, ncol = 9)
  rownames(m) = c("Songs","New Songs", "Overdubs", "In-degree", "Out-degree", "Betweenness")
  colnames(m) = c("Songs","New Songs", "Overdubs", "In-degree", "Out-degree", "Betweenness", "Mean", "Min", "Max")
  for(i in 1:6) {
    m[i,i] = 1
  }
  
  #seleziona solo autori di CANZONI (overdub e nuove)
  d = data[data$songs_written != 0, ]
  m[1,2] = cor(d$songs_written, d$new_songs_written, method = "spearman")
  m[1,3] = cor(d$songs_written, d$overdubs_written, method = "spearman")
  m[1,4] = cor(d$songs_written, d$indegree/length(d$indegree), method = "spearman")
  m[1,5] = cor(d$songs_written, d$outdegree/length(d$indegree), method = "spearman")
  m[1,6] = cor(d$songs_written, d$betweenesscentrality, method = "spearman")
  
  #seleziona solo autori di NUOVE CANZONI
  d = data[data$new_songs_written != 0, ]
  m[2,3] = cor(d$new_songs_written, d$overdubs_written, method = "spearman")
  m[2,4] = cor(d$new_songs_written, d$indegree/length(d$indegree), method = "spearman")
  m[2,5] = cor(d$new_songs_written, d$outdegree/length(d$indegree), method = "spearman")
  m[2,6] = cor(d$new_songs_written, d$betweenesscentrality, method = "spearman")
  
  #seleziona solo autori di OVERDUBS
  d = data[data$overdubs_written != 0, ]
  m[3,4] = cor(d$overdubs_written, d$indegree/length(d$indegree), method = "spearman")
  m[3,5] = cor(d$overdubs_written, d$outdegree/length(d$indegree), method = "spearman")
  m[3,6] = cor(d$overdubs_written, d$betweenesscentrality, method = "spearman")
  
  #su tutti gli autori
  d = data[data$songs_written != 0, ]
  m[4,5] = cor(d$indegree/length(d$indegree), d$outdegree/length(d$indegree), method = "spearman")
  m[4,6] = cor(d$indegree/length(d$indegree), d$betweenesscentrality, method = "spearman")
  
  #su tutti gli autori
  m[5,6] = cor(d$outdegree/length(d$indegree), d$betweenesscentrality, method = "spearman")
  
  #calcolo di MEDIA, MIN e MAX
  d = data[data$songs_written != 0, ]
  m[1,7] = mean(d$songs_written)
  m[1,8] = min(d$songs_written)
  m[1,9] = max(d$songs_written)
  
  d = data[data$new_songs_written != 0, ]
  m[2,7] = mean(d$new_songs_written)
  m[2,8] = min(d$new_songs_written)
  m[2,9] = max(d$new_songs_written)
  
  d = data[data$overdubs_written != 0, ]
  m[3,7] = mean(d$overdubs_written)
  m[3,8] = min(d$overdubs_written)
  m[3,9] = max(d$overdubs_written)
  
  d = data[data$songs_written != 0, ]
  m[4,7] = mean(d$indegree/length(d$indegree))
  m[4,8] = min(d$indegree/length(d$indegree))
  m[4,9] = max(d$indegree/length(d$indegree))
  
  m[5,7] = mean(d$outdegree/length(d$indegree))
  m[5,8] = min(d$outdegree/length(d$indegree))
  m[5,9] = max(d$outdegree/length(d$indegree))
  
  m[6,7] = mean(d$betweenesscentrality)
  m[6,8] = min(d$betweenesscentrality)
  m[6,9] = max(d$betweenesscentrality)
  
  for(i in 1:nrow(m)) {
    for(j in 1:nrow(m)) {
      m[j,i] = m[i,j]
    }
  }
  
  write.table(m, file=paste(genre, " cross correlation.tsv", sep=""), sep="\t")
}

genres = c("GENERAL",
           "ALTERNATIVE E ELECTRONIC",
           "HIP HOP E R&B",
           "JAZZ E CLASSICAL",
           "ROCK E BLUES")

filenames = c("Feedback graph 2 - Generale (non orientato) [Nodes].csv",
              "Feedback graph 2 - Generale (orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - AlternativeElectronic (non orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - AlternativeElectronic (orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - HipHopR&B (non orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - HipHopR&B (orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - JazzClassical (non orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - JazzClassical (orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - RockBlues (non orientato) [Nodes].csv",
              "Feedback graph MacroGeneri 3 - RockBlues (orientato) [Nodes].csv")

for(i in 1:length(genres)) {
  dir = "~/Dropbox (Personale)/Songtree/6. Cross correlation table/"
  crossCorrelation(dir, filenames[i + (i - 1)], filenames[i + (i)], genres[i])
}