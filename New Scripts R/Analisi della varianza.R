setwd("~/Dropbox (Personale)/Songtree/10. Analisi della varianza/")

d1 = read.csv("CSV/Feedback graph 2 - Generale (orientato) [Nodes].csv", sep="\t")
d2 = read.csv("CSV/Feedback graph 2 - Generale (non orientato) [Nodes].csv", sep="\t")
centrality = merge(d1, d2, by = "id")
centrality = centrality[, c("id", "indegree", "outdegree", "betweenesscentrality")]

alternativeElectronic = read.csv("CSV/Feedback graph MacroGeneri 3 - AlternativeElectronic (orientato) [Nodes].csv", sep="\t")
alternativeElectronic = alternativeElectronic[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
alternativeElectronic = merge(alternativeElectronic, centrality, by = "id")
alternativeElectronic = alternativeElectronic[alternativeElectronic$songs_written != 0, ]
alternativeElectronic$genre = "alternativeElectronic"

hipHopRB = read.csv("CSV/Feedback graph MacroGeneri 3 - HipHopR&B (orientato) [Nodes].csv", sep = "\t")
hipHopRB = hipHopRB[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
hipHopRB = merge(hipHopRB, centrality, by = "id")
hipHopRB = hipHopRB[hipHopRB$songs_written != 0, ]
hipHopRB$genre = "hiphopRnB"

jazzClassical = read.csv("CSV/Feedback graph MacroGeneri 3 - JazzClassical (orientato) [Nodes].csv", sep="\t")
jazzClassical = jazzClassical[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
jazzClassical = merge(jazzClassical, centrality, by = "id")
jazzClassical = jazzClassical[jazzClassical$songs_written != 0, ]
jazzClassical$genre = "jazzClassical"

rockBlues = read.csv("CSV/Feedback graph MacroGeneri 3 - RockBlues (orientato) [Nodes].csv", sep="\t")
rockBlues = rockBlues[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
rockBlues = merge(rockBlues, centrality, by = "id")
rockBlues = rockBlues[rockBlues$songs_written != 0, ]
rockBlues$genre = "rockBlues"

#in un unico file tutti i valori per gli autori dei diversi generi
data = rbind(alternativeElectronic, hipHopRB, jazzClassical, rockBlues)

attach(data)

#Test KRUSKAL-WALLIS (non parametrico)
kruskal.test(data$songs_written ~ data$genre)
kruskal.test(new_songs_written ~ genre)
kruskal.test(overdubs_written ~ genre)
kruskal.test(indegree ~ genre)
kruskal.test(outdegree ~ genre)
kruskal.test(betweenesscentrality ~ genre)

#Test ANOVA (parametrico)
summary(lm(songs_written ~ genre))
summary(lm(new_songs_written ~ genre))
summary(lm(overdubs_written ~ genre))
summary(lm(indegree ~ genre))
summary(lm(outdegree ~ genre))
summary(lm(betweenesscentrality ~ genre))

#ALTRO - PRECONDIZIONI ANOVA

#normalizzare la distribuzione (INCOMPLETO)
library(MASS)
modello = aov(songs_written ~ genre)
boxcox(modello)

#test omoschedaticità (non passato per song, new song e overdub)
library(car)
leveneTest(songs_written, genre)
leveneTest(new_songs_written, genre)
leveneTest(overdubs_written, genre)
leveneTest(indegree, genre)
leveneTest(outdegree, genre)
leveneTest(betweenesscentrality, genre)
