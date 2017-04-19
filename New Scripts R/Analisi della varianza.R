setwd("~/Dropbox (Personale)/Songtree/10. Analisi della varianza/")

d1 = read.csv("CSV/Feedback graph 2 - Generale (orientato) [Nodes].csv", sep="\t")
d2 = read.csv("CSV/Feedback graph 2 - Generale (non orientato) [Nodes].csv", sep="\t")
centrality = merge(d1, d2, by = "id")
centrality = centrality[, c("id", "indegree", "outdegree", "betweenesscentrality")]

alternativeElectronic = read.csv("CSV/Feedback graph MacroGeneri 3 - AlternativeElectronic (orientato) [Nodes].csv", sep="\t")
alternativeElectronic = alternativeElectronic[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
alternativeElectronic = merge(alternativeElectronic, centrality, by = "id")
alternativeElectronic = alternativeElectronic[alternativeElectronic$songs_written != 0, ]
alternativeElectronic$genre = "AlternAndElectr"

hipHopRB = read.csv("CSV/Feedback graph MacroGeneri 3 - HipHopR&B (orientato) [Nodes].csv", sep = "\t")
hipHopRB = hipHopRB[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
hipHopRB = merge(hipHopRB, centrality, by = "id")
hipHopRB = hipHopRB[hipHopRB$songs_written != 0, ]
hipHopRB$genre = "HipHopAndRnB"

jazzClassical = read.csv("CSV/Feedback graph MacroGeneri 3 - JazzClassical (orientato) [Nodes].csv", sep="\t")
jazzClassical = jazzClassical[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
jazzClassical = merge(jazzClassical, centrality, by = "id")
jazzClassical = jazzClassical[jazzClassical$songs_written != 0, ]
jazzClassical$genre = "JazzAndClassical"

rockBlues = read.csv("CSV/Feedback graph MacroGeneri 3 - RockBlues (orientato) [Nodes].csv", sep="\t")
rockBlues = rockBlues[, c("id", "songs_written", "new_songs_written", "overdubs_written")]
rockBlues = merge(rockBlues, centrality, by = "id")
rockBlues = rockBlues[rockBlues$songs_written != 0, ]
rockBlues$genre = "RockAndBlues"

#in un unico file tutti i valori per gli autori dei diversi generi
data = rbind(alternativeElectronic, hipHopRB, jazzClassical, rockBlues)


data$genre = as.factor(data$genre)   #serve per evitare un errore sui gruppi al test kruskal wallis


#Test KRUSKAL-WALLIS (non parametrico)
#l’ipotesi nulla è che le varianze sono uguali fra di loro, e che dunque la variabile indipendente 
#non produca effetti sulla variabile dipendente.
kruskal.test(songs_written ~ genre, data = data)
kruskal.test(new_songs_written ~ genre, data = data)
kruskal.test(overdubs_written ~ genre, data = data)
kruskal.test(indegree ~ genre, data = data)
kruskal.test(outdegree ~ genre, data = data)
kruskal.test(betweenesscentrality ~ genre, data = data)


attach(data)
#Test ANOVA (parametrico)
#l’ipotesi nulla è che le varianze sono uguali fra di loro, e che dunque la variabile indipendente 
#non produca effetti sulla variabile dipendente.

mean(data[data$genre=='RockAndBlues',]$songs_written)
mean(data[data$genre=='HipHopAndRnB',]$songs_written)
mean(data[data$genre=='AlternativeAndElectronic',]$songs_written)
mean(data[data$genre=='JazzAndClassical',]$songs_written)

mean(data[data$genre=='RockAndBlues',]$new_songs_written)
mean(data[data$genre=='HipHopAndRnB',]$new_songs_written)
mean(data[data$genre=='AlternativeAndElectronic',]$new_songs_written)
mean(data[data$genre=='JazzAndClassical',]$new_songs_written)

mean(data[data$genre=='RockAndBlues',]$overdubs_written)
mean(data[data$genre=='HipHopAndRnB',]$overdubs_written)
mean(data[data$genre=='AlternativeAndElectronic',]$overdubs_written)
mean(data[data$genre=='JazzAndClassical',]$overdubs_written)

mean(data[data$genre=='RockAndBlues',]$indegree)
mean(data[data$genre=='HipHopAndRnB',]$indegree)
mean(data[data$genre=='AlternativeAndElectronic',]$indegree)
mean(data[data$genre=='JazzAndClassical',]$indegree)

mean(data[data$genre=='RockAndBlues',]$outdegree)
mean(data[data$genre=='HipHopAndRnB',]$outdegree)
mean(data[data$genre=='AlternativeAndElectronic',]$outdegree)
mean(data[data$genre=='JazzAndClassical',]$outdegree)

mean(data[data$genre=='RockAndBlues',]$betweenesscentrality)
mean(data[data$genre=='HipHopAndRnB',]$betweenesscentrality)
mean(data[data$genre=='AlternativeAndElectronic',]$betweenesscentrality)
mean(data[data$genre=='JazzAndClassical',]$betweenesscentrality)

s1 = aov(songs_written ~ genre)
s2 = aov(new_songs_written ~ genre)
s3 = aov(overdubs_written ~ genre)
s4 = aov(indegree ~ genre)
s5 = aov(outdegree ~ genre)
s6 = aov(betweenesscentrality ~ genre)

summary.lm(s1)
summary.lm(s2)
summary.lm(s3)
summary.lm(s4)
summary.lm(s5)
summary.lm(s6)

par(mfrow = c(2,2))
par(mar=c(1,1,1,1))
plot(s1)
plot(s2)
plot(s3)
plot(s4)
plot(s5)
plot(s6)

library(multcomp)
library(sandwich)
par(mfrow = c(1,1))
par(mar=c(5,16,5,1))

posthoc2 = glht(s1, linfct = mcp(genre = "Tukey"), vcov = sandwich)
summary(posthoc2)
plot(posthoc2, sub="Songs written")

posthoc2 = glht(s2, linfct = mcp(genre = "Tukey"), vcov = sandwich)
summary(posthoc2)
plot(posthoc2, sub="New songs written")

posthoc2 = glht(s3, linfct = mcp(genre = "Tukey"), vcov = sandwich)
summary(posthoc2)
plot(posthoc2, sub="Overdubs written")

posthoc2 = glht(s4, linfct = mcp(genre = "Tukey"), vcov = sandwich)
summary(posthoc2)
plot(posthoc2, sub="Indegree")

posthoc2 = glht(s5, linfct = mcp(genre = "Tukey"), vcov = sandwich)
summary(posthoc2)
plot(posthoc2, sub="Outdegree")

posthoc2 = glht(s6, linfct = mcp(genre = "Tukey"), vcov = sandwich)
summary(posthoc2)
plot(posthoc2, sub="Betweenness")


#DATI SUI GRUPPI
library(plyr)
ddply(data, c("genre"), summarise, N = length(songs_written), mean = mean(songs_written))
ddply(data, c("genre"), summarise, N = length(new_songs_written), mean = mean(new_songs_written))
ddply(data, c("genre"), summarise, N = length(overdubs_written), mean = mean(overdubs_written))
ddply(data, c("genre"), summarise, N = length(indegree), mean = mean(indegree))
ddply(data, c("genre"), summarise, N = length(outdegree), mean = mean(outdegree))
ddply(data, c("genre"), summarise, N = length(betweenesscentrality), mean = mean(betweenesscentrality))

#ALTRO - PRECONDIZIONI ANOVA

#verifica della normalità della distribuzione (nel caso di una distribuzione normale, nel box-plot 
#le distanze tra ciascun quartile e la mediana saranno uguali, così pure avranno uguale lunghezza 
#le linee che si allungano dai bordi della scatola (baffi))
#Si vede che le distribuzioni non sono normali
plot((songs_written + 1) ~ genre, log="y", xlab="", ylab="Songs written")
plot((new_songs_written + 1) ~ genre, log="y", xlab="", ylab="New Songs written")
plot((overdubs_written + 1) ~ genre, log="y", xlab="", ylab="Overdubs written")
plot((indegree + 1) ~ genre, log="y", xlab="", ylab="In Degree")
plot((outdegree + 1) ~ genre, log="y", xlab="", ylab="Out Degree")
plot((betweenesscentrality + 1) ~ genre, log="y", xlab="", ylab="Betweenness")


library(MASS)
modello = aov(songs_written ~ genre)
boxcox(modello)

#test omoschedaticità (non passato per song, new song e overdub)
#the null hypothesis is that all populations variances are equal
library(car)
leveneTest(songs_written, genre)
leveneTest(new_songs_written, genre)
leveneTest(overdubs_written, genre)
leveneTest(indegree, genre)
leveneTest(outdegree, genre)
leveneTest(betweenesscentrality, genre)


library("PMCMR")
posthoc.kruskal.dunn.test(x=songs_written, g=genre, p.adjust.method="bonferroni")
posthoc.kruskal.dunn.test(x=new_songs_written, g=genre, p.adjust.method="bonferroni")
posthoc.kruskal.dunn.test(x=overdubs_written, g=genre, p.adjust.method="bonferroni")
posthoc.kruskal.dunn.test(x=indegree, g=genre, p.adjust.method="bonferroni")
posthoc.kruskal.dunn.test(x=outdegree, g=genre, p.adjust.method="bonferroni")
posthoc.kruskal.dunn.test(x=betweenesscentrality, g=genre, p.adjust.method="bonferroni")
