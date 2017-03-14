setwd("/Users/antoniolategano/Dropbox (Università)/Risultati/9. Statistiche/MANOVA/")

#10 genres
data = read.csv("CSV/ALL 10.csv", sep="\t", header=T)
genres = as.factor(data[,1])
values = as.matrix(data[,2:7])

#24 genres
data = read.csv("CSV/ALL 24.csv", sep="\t", header=T)
genres = as.factor(data[,1])
values = as.matrix(data[,2:7])

#manova calculation
out = manova(cbind(SONGS, IN.DEEGREE, OUT.DEGREE, BETWEENNESS) ~ GENRE, data = data)
summary(out)
summary.aov(out)

#kruskal test (anova equivalent non-parametric) per ogni variabile dipendente
kruskal.test(SONGS ~ GENRE, data=data)
kruskal.test(NEW.SONGS ~ GENRE, data=data)
kruskal.test(OVERDUBS ~ GENRE, data=data)
kruskal.test(IN.DEEGREE ~ GENRE, data=data)
kruskal.test(OUT.DEGREE ~ GENRE, data=data)
kruskal.test(BETWEENNESS ~ GENRE, data=data)

#TESTING THE ASSUMPTIONS
SONGSresGENRES = lm(data$SONGS~genres)$residuals
NEWSONGSresGENRES = lm(data$NEW.SONGS~genres)$residuals
OVERDUBSresGENRES = lm(data$OVERDUBS~genres)$residuals
INDEGREEresGENRES = lm(data$IN.DEEGREE~genres)$residuals
OUTDEGREEresGENRES = lm(data$OUT.DEGREE~genres)$residuals
BETWEENNESSresGENRES = lm(data$BETWEENNESS~genres)$residuals

#test normality statistically
shapiro.test(SONGSresGENRES)
shapiro.test(NEWSONGSresGENRES)
shapiro.test(OVERDUBSresGENRES)
shapiro.test(INDEGREEresGENRES)
shapiro.test(OUTDEGREEresGENRES)
shapiro.test(BETWEENNESSresGENRES)

#test normality graphically
boxplot(lm(data$SONGS~genres)$residuals~genres)

#test omoschedasticità
levene.test(SONGS, GENRE)
levene.test(NEW.SONGS, GENRE)
levene.test(OVERDUBS, GENRE)
levene.test(IN.DEEGREE, GENRE)
levene.test(OUT.DEGREE, GENRE)
levene.test(BETWEENNESS, GENRE)

#plot for each variable
boxplot(data$SONGS~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes Songs")
quartz.save(file=paste("10 Songs.png", sep=""), dpi=400)
dev.off()

###problema con valori pari a 0 per il logaritmo
boxplot(log(data$NEW.SONGS)~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes New Songs")
quartz.save(file=paste("10 New Songs.png", sep=""), dpi=400)
dev.off()

boxplot(data$OVERDUBS~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes Overdubs")
quartz.save(file=paste("10 Overdubs.png", sep=""), dpi=400)
dev.off()

boxplot(data$IN.DEGREE~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="In Degree")
quartz.save(file=paste("10 In degree.png", sep=""), dpi=400)
dev.off()

boxplot(data$OUT.DEGREE~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="In Degree")
quartz.save(file=paste("10 Out degree.png", sep=""), dpi=400)
dev.off()

boxplot(data$BETWEENNESS~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Betweenness")
quartz.save(file=paste("10 Betweenness.png", sep=""), dpi=400)
dev.off()


#all 24 genres 
data = read.csv("CSV/ALL 24.csv", header=T, sep="\t")
genres = as.factor(data[,1])
values =as.matrix(data[,2:7])

out = manova(values ~ genres)
summary.aov(out)

boxplot(data$Songs~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes Songs")
quartz.save(file=paste("24 Songs.png", sep=""), dpi=400)
dev.off()

boxplot(data$New.Songs~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes New Songs")
quartz.save(file=paste("24 New Songs.png", sep=""), dpi=400)
dev.off()

boxplot(data$Overdubs~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes Overdubs")
quartz.save(file=paste("24 Overdubs.png", sep=""), dpi=400)
dev.off()

boxplot(data$In.Degree~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="In Degree")
quartz.save(file=paste("24 In degree.png", sep=""), dpi=400)
dev.off()

boxplot(data$Out.Degree~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="In Degree")
quartz.save(file=paste("24 Out degree.png", sep=""), dpi=400)
dev.off()

boxplot(data$Betweenness~genres, las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Betweenness")
quartz.save(file=paste("24 Betweenness.png", sep=""), dpi=400)
dev.off()