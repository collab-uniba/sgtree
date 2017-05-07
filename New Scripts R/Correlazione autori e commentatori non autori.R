setwd("~/Dropbox (Personale)/Songtree/5. Centrality of Authors and Commenters Non Authors/Nuovi CSV/")
data1 = read.csv("Feedback graph 2 - Generale (orientato) [Nodes].csv", sep="\t")
data2 = read.csv("Feedback graph 2 - Generale (non orientato) [Nodes].csv", sep="\t")
data = merge(data1, data2, by = "id")
data3 = read.csv("ID_commenters_non_authors.tsv")
data4 = read.csv("ID_commenting_authors.tsv")

authors = data[data$songs_written >= 1, ]
commenters = merge(data3, data, by = "id")
commenting_authors = merge(data4, data, by = "id")

wilcox.test(authors$outdegree, commenters$outdegree)
wilcox.test(commenters$outdegree, commenting_authors$outdegree)
#wilcox.test(authors$betweenesscentrality, commenters$betweenesscentrality)