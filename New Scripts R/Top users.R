setwd("~/Dropbox (Personale)/Songtree/11. Top users/")

#RANK UTENTI SULLA BASE DEI PROPRI FOLLOWER 
data = read.csv("CSV/Follow Graph - TOP USERS [Nodes].tsv", sep='\t')
#ordina in maniera decrescente in base al numero di follower
data = data[order(-data$indegree), ]
#aggiunge un rank per indicare chi ha più follower
data$rank <- seq.int(nrow(data))
#seleziona solo id e rank (riferito ai follower)
rank_followers = data[ ,c("id", "rank")]

#FEEDBACK GRAPH
data = read.csv("CSV/Feedback graph - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Feedback graph GENERAL (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Feedback graph GENERAL (outdegree).csv", row.names = F)

#ALTERNATIVE E ELECTRONIC
data = read.csv("CSV/Feedback graph MacroGeneri 3 - AlternativeElectronic - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Feedback graph ALTERNATIVE ELECTRONIC (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Feedback graph ALTERNATIVE ELECTRONIC (outdegree).csv", row.names = F)

#HIP HOP E R&B
data = read.csv("CSV/Feedback graph MacroGeneri 3 - HipHopR&B - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Feedback graph HIPHOP R&B (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Feedback graph HIPHOP R&B (outdegree).csv", row.names = F)

#JAZZ E CLASSICAL
data = read.csv("CSV/Feedback graph MacroGeneri 3 - JazzClassical - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Feedback graph JAZZ CLASSICAL (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Feedback graph JAZZ CLASSICAL (outdegree).csv", row.names = F)

#ROCK E BLUES
data = read.csv("CSV/Feedback graph MacroGeneri 3 - RockBlues - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Feedback graph ROCK BLUES (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Feedback graph ROCK BLUES (outdegree).csv", row.names = F)

#COLLABORATION GRAPH
data = read.csv("CSV/Collaboration graph - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "degree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$degree), ]
write.csv2(top_users, file = "Collaboration graph (degree).csv", row.names = F)

#OVERDUB GRAPH
data = read.csv("CSV/Overdub Graph - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Overdub graph (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Overdub graph (outdegree).csv", row.names = F)

#FOLLOW GRAPH
data = read.csv("CSV/Follow Graph - TOP USERS [Nodes].tsv", sep='\t')
top_users = data[, c("id", "label", "indegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$indegree), ]
write.csv2(top_users, file = "Follow graph (indegree).csv", row.names = F)
top_users = data[, c("id", "label", "outdegree")]
top_users = merge(top_users, rank_followers, by = "id")
top_users = top_users[order(-top_users$outdegree), ]
write.csv2(top_users, file = "Follow graph (outdegree).csv", row.names = F)
