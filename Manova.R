setwd("~/Dropbox (Personale)/Songtree/9. Statistiche/MANOVA")
library(car)

#10 genres
data = read.csv("CSV/ALL 10.csv", sep="\t", header=T)
genres = as.factor(data[,1])
values = as.matrix(data[,2:7])

#24 genres
data = read.csv("CSV/ALL 24.csv", sep="\t", header=T)
genres = as.factor(data[,1])
values = as.matrix(data[,2:7])

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

#TESTING THE ASSUMPTIONS
SONGSresGENRES = lm(data$SONGS~genres)$residuals
NEWSONGSresGENRES = lm(data$NEW.SONGS~genres)$residuals
OVERDUBSresGENRES = lm(data$OVERDUBS~genres)$residuals
INDEGREEresGENRES = lm(data$IN.DEGREE~genres)$residuals
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

attach(data)
#test omoschedasticità
leveneTest(SONGS, GENRE)
leveneTest(NEW.SONGS, GENRE)
leveneTest(OVERDUBS, GENRE)
leveneTest(IN.DEGREE, GENRE)
leveneTest(OUT.DEGREE, GENRE)
leveneTest(BETWEENNESS, GENRE)

#PLOT FOR EACH VARIABLE
boxplot(data$SONGS~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes Songs")
quartz.save(file=paste("24 Songs.png", sep=""), dpi=400)
dev.off()

###aggiunto 1 ad ogni valore per evitare problemi con la scala logaritmica
boxplot((data$NEW.SONGS+1)~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes New Songs")
quartz.save(file=paste("24 New Songs.png", sep=""), dpi=400)
dev.off()

boxplot((data$OVERDUBS+1)~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Author writes Overdubs")
quartz.save(file=paste("24 Overdubs.png", sep=""), dpi=400)
dev.off()

boxplot((data$IN.DEGREE+1)~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="In Degree")
quartz.save(file=paste("24 In degree.png", sep=""), dpi=400)
dev.off()

boxplot((data$OUT.DEGREE+1)~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="In Degree")
quartz.save(file=paste("24 Out degree.png", sep=""), dpi=400)
dev.off()

boxplot((data$BETWEENNESS+1)~genres, log="y", las=2, par(mar = c(8, 4, 2, 2)), par(bg = "white"), main="Betweenness")
quartz.save(file=paste("24 Betweenness.png", sep=""), dpi=400)
dev.off()