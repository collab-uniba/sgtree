setwd("~/Dropbox (Università)/Cartella del team Università/Risultati/Generi/Pop/")
data = read.csv("indegree weighted outdegree.tsv", sep="\t", header=TRUE)
#trova righe dove ci sono zeri e le elimina
row_sub = apply(data, 1, function(row) all(row !=0 ))
data = data[row_sub,]

#calcolo indice di pearson
sub = paste("Pearson's correlation = ", cor(data, method="pearson"))

plot(data$weighted.outdegree, data$indegreee, log="xy", xlab="Sent Comments", ylab="In degree", sub=sub[2])