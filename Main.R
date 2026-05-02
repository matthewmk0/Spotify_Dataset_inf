#STAT 3120
#Statistical Analysis of Spotify Dataset.

#Needed Packages
library(readxl)
library(dplyr)
library(ggplot2)
library(janitor)
library(epitools)
library(gt)
library(car)

#Export Dataset, substitute "path/to/file" with actual path
sp <- read_excel("path/to/file")
View(sp) #To view dataset in R

#=============descriptive stats and cleaning=============#
#=Danceability, Quantitative
dance <- sp$danceability
summary(dance) #min 0.166, Q1 0.511, med 0.636, mea 0.629, Q3 0.754, max 0.954
sd(dance) #0.159
#===
#=Energy, Quantitative
energy <- sp$energy
summary(energy) #min 0.109, Q1 0.643, med 0.823, mea 0.778, Q3 0.935, max 0.998
sd(energy) #0.178
#===
#=Loudness, Quantitative, cleaning required
clean_sp <- filter(sp, loudness < 0) #remove values greater than 0.
loud <- clean_sp$loudness
var(loud) #8.166
sd(loud) #2.858
summary(loud) #min -17.912, Q1 -8.063, med -6.126, mea -6.471, Q3 -4.737, max -0.344
remaining_loud <- (length(sp$loudness)-length(loud)) #5 values were removed
#===
#=Tempo, Quantitative
tempo <- sp$tempo
summary(tempo) #min 81.99, Q1 129.98, med 145.00, mea 147.22, Q3 160.18, max 220.04
sd(tempo) #23.244
#===

#=Qualitative Variables
table(sp$genre) #Dark Trap 43, DnB 38, Emo 20, Hardstyle 48, HipHop 38, Pop 2, Psytrance 50, Rap 17
                #RnB 20, Techhouse 44, Techno 32, Trance 40, Trap 38, Trap M 34, Underground 79.
#===
#=Creating DanceCat by separating Danceability by the mean
sp$dancecat <- ifelse(sp$danceability > .629, "Danceable",
                                    "Not Danceable")
#=Removing pop because low count of 2
clean_sp <- sp %>% filter(genre != "Pop")
#===
#=New contingency table
tab <- table(clean_sp$dancecat, clean_sp$genre)
#=Expected values
expected <- chisq.test(tab)$expected
#===

#=============Graphs=============#
#===Create the boxplot with histogram for danceability===
#=Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
#=Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(dance_var , horizontal=TRUE , ylim=c(0,1), xaxt="n" , col=rgb(0.8,0.8,0,0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(dance_var , breaks=40 , col=rgb(0.2,0.8,0.5,0.5) , border=F , main="" , xlab="Danceability", ylab="Frequency", xlim=c(0,1))
#===
#===Create the boxplot with histogram for energy===
#=Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
#=Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(energy_var , horizontal=TRUE , ylim=c(0,1), xaxt="n" , col=rgb(0.2, 0.4, 0.8, 0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(energy_var , breaks=40 , col=rgb(0.2, 0.4, 0.8, 0.8) , border=F , main="" , xlab="Energy", ylab="Frequency", xlim=c(0,1))
#===
#===Create the boxplot with histogram for Loudness===
#=Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
#=Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(clean_loud , horizontal=TRUE , ylim=c(-30,0), xaxt="n" , col=rgb(0.2, 0.7, 0.4, 0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(clean_loud , breaks=40 , col=rgb(0.1, 0.5, 0.3, 0.8) , border=F , main="" , xlab="Loudness", ylab="Frequency", xlim=c(-30,0))
#===
#===Create the boxplot with histogram for Tempo===
# Layout to split the screen
layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,8))
# Draw the boxplot and the histogram 
par(mar=c(0, 3.1, 1.1, 2.1))
boxplot(tempo_var , horizontal=TRUE , ylim=c(50,250), xaxt="n" , col=rgb(0.6, 0.3, 0.8, 0.5) , frame=F)
par(mar=c(4, 5, 1.1, 2.1))
hist(tempo_var , breaks=40 , col=rgb(0.7, 0.2, 0.6, 0.8) , border=F , main="" , xlab="Tempo", ylab="Frequency", xlim=c(50,250))
#===
#===Create the Bar plot for Genre===
ggplot(sp, aes(x=genre)) + geom_bar()
# without pop
ggplot(clean_sp, aes(x=genre)) + geom_bar()
#===
#===Stacked Proportional bar chart genre dance===
ggplot(clean_sp, aes(x = genre, fill = dancecat))+
    geom_bar(position = "fill")+
    labs(y = "Proportion")

    
#=============Statistical Tests=============#
#===test 1===#
#===
# Multiple linear regression analysis
#===
#Reg Test
model <- lm(danceability ~ loudness + tempo, data = sp)
summary(model) #df=540, f-stat=25.09, p=3.803e-11
#===
# Checking conditions
vif(model) # Multicollinearity check, passed bc close to 1.
plot(model, which=1) # Residual plot, passed graph looks decently centered around the middle.
plot(model, which=2) # Q-Q plot, passed no jarring signs.
#===


#===test 2===#
#=Verifying expected counts
all(expected >= 5) #true, satisfied
#=Chi Square Test-of-Independence
chi_result <- chisq.test(tab)
chi_result #x-squared=186.87, df=13, p<2.2e-16
