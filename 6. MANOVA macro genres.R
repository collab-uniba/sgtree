setwd("~/Dropbox (Personale)/Songtree/11. Statistiche/KRUSKAL-WALLIS & ANOVA/CSV/")
data = read.csv("ALL 24 (macro genres).csv", sep="\t", header = T)
genres = as.factor(data[,1])
values = as.matrix(data[,2:7])

mean(data[data$GENRE=='RockAndBlues',]$SONGS)
mean(data[data$GENRE=='HipHopAndR&B',]$SONGS)
mean(data[data$GENRE=='AlternativeAndElectronic',]$SONGS)
mean(data[data$GENRE=='JazzAndClassical',]$SONGS)

mean(data[data$GENRE=='RockAndBlues',]$IN.DEGREE)
mean(data[data$GENRE=='HipHopAndR&B',]$IN.DEGREE)
mean(data[data$GENRE=='AlternativeAndElectronic',]$IN.DEGREE)
mean(data[data$GENRE=='JazzAndClassical',]$IN.DEGREE)

mean(data[data$GENRE=='RockAndBlues',]$OUT.DEGREE)
mean(data[data$GENRE=='HipHopAndR&B',]$OUT.DEGREE)
mean(data[data$GENRE=='AlternativeAndElectronic',]$OUT.DEGREE)
mean(data[data$GENRE=='JazzAndClassical',]$OUT.DEGREE)

mean(data[data$GENRE=='RockAndBlues',]$BETWEENNESS)
mean(data[data$GENRE=='HipHopAndR&B',]$BETWEENNESS)
mean(data[data$GENRE=='AlternativeAndElectronic',]$BETWEENNESS)
mean(data[data$GENRE=='JazzAndClassical',]$BETWEENNESS)

#anova calculation
modSONGS = aov(SONGS ~ GENRE, data = data)
summary.lm(modSONGS)

modINDEGREE = aov(IN.DEGREE ~ GENRE, data = data)
summary.lm(modINDEGREE)

modOUTDEGREE = aov(OUT.DEGREE ~ GENRE, data = data)
summary.lm(modOUTDEGREE)

modBETWEENNESS = aov(BETWEENNESS ~ GENRE, data = data)
summary.lm(modBETWEENNESS)

#manova calculation
out = manova(cbind(SONGS, IN.DEGREE, OUT.DEGREE, BETWEENNESS) ~ GENRE, data = data)
summary.manova(out)
summary.aov(out)
summary.lm(out)

#kruskal test (anova equivalent non-parametric) per ogni variabile dipendente
kruskal.test(SONGS ~ GENRE, data=data)
kruskal.test(NEW.SONGS ~ GENRE, data=data)
kruskal.test(OVERDUBS ~ GENRE, data=data)
kruskal.test(IN.DEGREE ~ GENRE, data=data)
kruskal.test(OUT.DEGREE ~ GENRE, data=data)
kruskal.test(BETWEENNESS ~ GENRE, data=data)
