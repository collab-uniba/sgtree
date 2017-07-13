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

median(authors$outdegree)
median(commenters$outdegree)
median(commenting_authors$outdegree)

mean(authors$outdegree/length(authors$outdegree))
mean(commenters$outdegree/length(commenters$outdegree))
mean(commenting_authors$outdegree/length(commenting_authors$outdegree))

#################################################################################

data = read.csv("Out-degree and weighted out-degree.csv", sep="\t")
d1 = read.csv("ID_active_users.tsv", sep="\t")

authors = data[data$songs_written >= 1, ]
authors = authors[ , c("id", "outdegree", "weighted.outdegree")]
write.csv2(authors, "Authors_outdegree.csv")

non_authors = data[data$songs_written == 0, ]
non_authors = non_authors[ , c("id", "outdegree", "weighted.outdegree")]
write.csv2(non_authors, "Non_Authors_outdegree.csv")

active_users = merge(data, d1, by="id")
active_users = active_users[ , c("id", "outdegree", "weighted.outdegree")]
write.csv2(active_users, "Active_users_outdegree.csv")

wilcox.test(authors$outdegree, non_authors$outdegree)
wilcox.test(authors$weighted.outdegree, non_authors$weighted.outdegree)
wilcox.test(authors$outdegree, active_users$outdegree)
wilcox.test(authors$weighted.outdegree, active_users$weighted.outdegree)

median(authors$outdegree)
median(authors$weighted.outdegree)
median(non_authors$outdegree)
median(non_authors$weighted.outdegree)
median(active_users$outdegree)
median(active_users$weighted.outdegree)

mean(authors$outdegree)
mean(authors$weighted.outdegree)
mean(non_authors$outdegree)
mean(non_authors$weighted.outdegree)
mean(active_users$outdegree)
mean(active_users$weighted.outdegree)

length = length(authors$outdegree)
mean(authors$outdegree/length)
mean(authors$weighted.outdegree/length)

length = length(non_authors$outdegree)
mean(non_authors$outdegree/length)
mean(non_authors$weighted.outdegree/length)

length = length(active_users$outdegree)
mean(active_users$outdegree/length)
mean(active_users$weighted.outdegree/length)

