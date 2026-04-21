library(readxl)
sp <- read_excel("/Users/matty/Documents/code-projects/Stats projects/Inf_Stats/spotify_set/spotify_stat3120.xls")
View(sp)

library(dplyr)
#descriptive stats
dance_var <- sp$danceability
summary(sp$danceability)
sd(sp$danceability)

energy_var <- sp$energy
summary(sp$energy)
sd(sp$energy)

clean_sp <- filter(sp, loudness < 0)
clean_loud <- clean_sp$loudness
sd(clean_loud)
var(clean_loud)
summary(clean_loud$loudness)
sd(sd$loudness)

tempo_var <- sp$tempo
summary(sp$tempo)
sd(sp$tempo)

# ---Create the boxplot with histogram for danceability---
# Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
# Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(dance_var , horizontal=TRUE , ylim=c(0,1), xaxt="n" , col=rgb(0.8,0.8,0,0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(dance_var , breaks=40 , col=rgb(0.2,0.8,0.5,0.5) , border=F , main="" , xlab="Danceability", ylab="Frequency", xlim=c(0,1))

# ---Create the boxplot with histogram for energy---
# Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
# Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(energy_var , horizontal=TRUE , ylim=c(0,1), xaxt="n" , col=rgb(0.2, 0.4, 0.8, 0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(energy_var , breaks=40 , col=rgb(0.2, 0.4, 0.8, 0.8) , border=F , main="" , xlab="Energy", ylab="Frequency", xlim=c(0,1))

# ---Create the boxplot with histogram for Loudness---
# Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
# Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(clean_loud , horizontal=TRUE , ylim=c(-60,0), xaxt="n" , col=rgb(0.2, 0.7, 0.4, 0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(clean_loud , breaks=40 , col=rgb(0.1, 0.5, 0.3, 0.8) , border=F , main="" , xlab="Loudness", ylab="Frequency", xlim=c(-60,0))

# ---Create the boxplot with histogram for Tempo---
# Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
# Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(tempo_var , horizontal=TRUE , ylim=c(50,250), xaxt="n" , col=rgb(0.6, 0.3, 0.8, 0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(tempo_var , breaks=40 , col=rgb(0.7, 0.2, 0.6, 0.8) , border=F , main="" , xlab="Tempo", ylab="Frequency", xlim=c(50,250))
